package com.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.study.BoardDAO;
import com.board.study.BoardDTO;
import com.commons.action.Action;
import com.commons.action.ActionForward;

public class BoardReplyAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		BoardDTO dto = new BoardDTO();
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		dto.setBoard_num(board_num);
		dto.setBoard_id(request.getParameter("board_id"));
		dto.setBoard_subject(request.getParameter("board_subject"));
		dto.setBoard_content(request.getParameter("board_content"));
		dto.setBoard_re_ref(Integer.parseInt(request.getParameter("board_re_ref")));
		dto.setBoard_re_lev(Integer.parseInt(request.getParameter("board_re_lev")));
		dto.setBoard_re_seq(Integer.parseInt(request.getParameter("board_re_seq")));
		
		BoardDAO dao = new BoardDAO();
		int succ = dao.boardReply(dto);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (succ > 0) {
			out.println("<script>alert('답글 등록 성공');");
			out.println("location.href='boardDetailAction.bo?board_num=" + board_num + "';</script>");
		} else {
			out.println("<script>alert('답글 등록 실패');");
			out.println("history.go(-1);</script>");
		}
		return null;
	}
}