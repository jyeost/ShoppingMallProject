package minji.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import common.model.AddImgVO;
import common.model.ChildProductVO;
import common.model.ParentProductVO;

public class ProductDAO implements InterProductDAO {

	//field
	private DataSource ds; // DataSource ds :  ds는데이타 소스 // 아파치 톰캣이 제공하는 DBCP(DB Connection Pool)이다. 풀장에 conn을 띄우기
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ProductDAO() {
		
		try {
		  Context initContext = new InitialContext();
		  Context envContext  = (Context)initContext.lookup("java:/comp/env");
		  ds = (DataSource)envContext.lookup("jdbc/semi_oracle");

		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
		
	// 사용한 자원 반납하는 close() 메소드 생성하기
	private void close() {
		//거꾸로 반납
		
		try {
			if(rs != null) { rs.close(); rs=null;}
			if(pstmt != null) { pstmt.close(); pstmt=null;}
			if(conn != null) { conn.close(); conn=null;} // connection풀링 기법 사용 : 웹은 싱클톤패턴기법 사용하면 메모리 부족해진다.
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	// 상품 전체를 셀렉해와서 리스트로 뿌려주는 메소드
	@Override
	public List<ChildProductVO> selectAllProduct() throws SQLException {
		List<ChildProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select pname, pnum, price, pcolor, pimage1\n"+
					"from tbl_product_test\n"+
					"JOIN tbl_all_product_test \n"+
					"ON pid = fk_pid";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChildProductVO cvo =new ChildProductVO();
				
				cvo.setPnum(rs.getInt("pnum"));
				
				ParentProductVO ppvo = new ParentProductVO();
				ppvo.setPname(rs.getString("pname"));
				ppvo.setPrice(rs.getInt("price"));
				cvo.setParentProvo(ppvo); // JOIN
				
				cvo.setPcolor(rs.getString("pcolor")); 
				cvo.setPimage1(rs.getString("pimage1"));
				
				productList.add(cvo); 
			}
			
		} finally {
			close();
		}
		
		return productList;
	}// end of 상품 전체를 셀렉해와서 리스트로 뿌려주는 메소드

	
	
	// pnum을 가지고 상품 디테일을 알아오는 메소드 
	@Override
	public ChildProductVO selectOneDetail(String pnum) throws SQLException {
		
		ChildProductVO cpvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select pnum, fk_pid ,pcolor ,pimage1,salePcnt,pname,price ,pcontent\n"+
					"from tbl_product_test\n"+
					"JOIN tbl_all_product_test \n"+
					"ON pid = fk_pid\n"+
					"where pnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cpvo =new ChildProductVO();
				
				cpvo.setPnum(rs.getInt("pnum"));
				cpvo.setFk_pid(rs.getString("fk_pid"));
				cpvo.setPcolor(rs.getString("pcolor"));
				cpvo.setPimage1(rs.getString("pimage1"));
				cpvo.setSalePcnt(rs.getInt("salePcnt"));
				
				ParentProductVO ppvo = new ParentProductVO();
				ppvo.setPname(rs.getString("pname"));
				ppvo.setPrice(rs.getInt("price"));
				ppvo.setPcontent(rs.getString("pcontent"));
				
				cpvo.setParentProvo(ppvo);
				
				
			}
			
		} finally {
			close();
		}
		
		return cpvo;
	}// pnum을 가지고 상품 디테일을 알아오는 메소드 

	
	
	// 색깔이 다른 동일 제품들 조회해오기 
	@Override
	public List<ChildProductVO> SelectSameProduct(Map<String, String> paraMap) throws SQLException {
		
		List<ChildProductVO> productList = new ArrayList<>();
		
		
		try {
			conn = ds.getConnection();
			
			String sql = "select pimage1, pnum \n"+
						"from tbl_all_product_test\n"+
						"where FK_PID = ? and pnum !=  ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_pid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChildProductVO cpvo =new ChildProductVO();
				
				cpvo.setPimage1(rs.getString(1));
				cpvo.setPnum(rs.getInt(2));
		
				productList.add(cpvo);
			}
			
		} finally {
			close();
		}
		
		return productList;
		
	}// end of 색깔이 다른 동일 제품들 조회해오기 

	
	// 상품 리스트 페이지에서 간략보기 누르면 전체 상품의 이미지들만 나오는 상픔심플리스트 메소드 
	@Override
	public List<ChildProductVO> simpleAllProduct() throws SQLException{
		
		List<ChildProductVO> simpleList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select pnum, fk_pid, pimage1\n"+
						 "from tbl_all_product_test";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChildProductVO simpleCvo = new ChildProductVO();
				
				simpleCvo.setPnum(rs.getInt("pnum"));
				simpleCvo.setFk_pid(rs.getString("fk_pid"));
				simpleCvo.setPimage1(rs.getString("pimage1"));
				
				simpleList.add(simpleCvo); 
			}
			
		} finally {
			close();
		}

		return simpleList;
	}

	
	
	
	
	
	
}
