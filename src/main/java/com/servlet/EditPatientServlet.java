package com.servlet;

import com.dao.HospitalDAO;
import com.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editPatient")
public class EditPatientServlet extends HttpServlet {
    private HospitalDAO hospitalDAO;

    public void init() {
        hospitalDAO = new HospitalDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("displayPatients");
            return;
        }

        try {
            int patientID = Integer.parseInt(idStr);
            Patient patient = hospitalDAO.getPatientById(patientID);
            if (patient == null) {
                response.sendRedirect("displayPatients");
                return;
            }
            request.setAttribute("patient", patient);
            request.getRequestDispatcher("editPatient.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error fetching patient", e);
        }
    }
}
