package minsu.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class AdrUpdate extends AbstractController {

	// 주소를 수정하는 페이지 //
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/minsu/adrView.jsp");
			} catch(Exception e) {
				e.printStackTrace();
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/error.sun");
			}
		
	}

}
