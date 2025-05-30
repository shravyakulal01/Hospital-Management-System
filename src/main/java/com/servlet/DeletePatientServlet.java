package com.servlet;

import com.dao.HospitalDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deletePatient")
public class DeletePatientServlet extends HttpServlet {
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                hospitalDAO.deletePatient(id);
            } catch (SQLException e) {
                throw new ServletException("Error deleting patient", e);
            }
        }
        response.sendRedirect("displayPatients"); // After delete, redirect to the list
    }
}
