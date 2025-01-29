package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

//@WebServlet("/ClearSessionAttributeServlet")
public class ClearSessionAttributeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String attrName = request.getParameter("attr");
            if (attrName != null) {
                session.removeAttribute(attrName);
            }
        }
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
