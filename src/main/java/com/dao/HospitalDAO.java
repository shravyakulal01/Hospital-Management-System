package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Patient;

public class HospitalDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/HospitalDB";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_PATIENT_SQL = "INSERT INTO Patients (PatientName, Age, Gender, AdmissionDate, Ailment, AssignedDoctor) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PATIENT_SQL = "UPDATE Patients SET PatientName=?, Age=?, Gender=?, AdmissionDate=?, Ailment=?, AssignedDoctor=? WHERE PatientID=?";
    private static final String DELETE_PATIENT_SQL = "DELETE FROM Patients WHERE PatientID=?";
    private static final String SELECT_ALL_PATIENTS = "SELECT * FROM Patients";
    private static final String SELECT_BY_DATES = "SELECT * FROM Patients WHERE AdmissionDate BETWEEN ? AND ?";
    private static final String SELECT_BY_AILMENT = "SELECT * FROM Patients WHERE Ailment=?";
    private static final String SELECT_BY_DOCTOR = "SELECT * FROM Patients WHERE AssignedDoctor=?";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            throw new SQLException(e);
        }
    }

    public void addPatient(Patient patient) throws SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(INSERT_PATIENT_SQL)) {
            stmt.setString(1, patient.getPatientName());
            stmt.setInt(2, patient.getAge());
            stmt.setString(3, patient.getGender());
            stmt.setString(4, patient.getAdmissionDate());
            stmt.setString(5, patient.getAilment());
            stmt.setString(6, patient.getAssignedDoctor());
            stmt.executeUpdate();
        }
    }

    public void updatePatient(Patient patient) throws SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(UPDATE_PATIENT_SQL)) {
            stmt.setString(1, patient.getPatientName());
            stmt.setInt(2, patient.getAge());
            stmt.setString(3, patient.getGender());
            stmt.setString(4, patient.getAdmissionDate());
            stmt.setString(5, patient.getAilment());
            stmt.setString(6, patient.getAssignedDoctor());
            stmt.setInt(7, patient.getPatientID());
            stmt.executeUpdate();
        }
    }

    public void deletePatient(int id) throws SQLException {
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(DELETE_PATIENT_SQL)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    

    public List<Patient> getAllPatients() throws SQLException {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patients";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Patient p = new Patient(
                    rs.getInt("PatientID"),
                    rs.getString("PatientName"),
                    rs.getInt("Age"),
                    rs.getString("Gender"),
                    rs.getDate("AdmissionDate").toString(),
                    rs.getString("Ailment"),
                    rs.getString("AssignedDoctor")
                );
                System.out.println("Loaded patient: " + p.getPatientName());
                patients.add(p);
            }
        }
        return patients;
    }
    public Patient getPatientByID(int id) throws SQLException {
        Patient patient = null;
        String sql = "SELECT * FROM Patients WHERE PatientID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    patient = new Patient(
                        rs.getInt("PatientID"),
                        rs.getString("PatientName"),
                        rs.getInt("Age"),
                        rs.getString("Gender"),
                        rs.getDate("AdmissionDate").toString(),
                        rs.getString("Ailment"),
                        rs.getString("AssignedDoctor")
                    );
                }
            }
        }
        return patient;
    }
    public Patient getPatientById(int id) throws SQLException {
        Patient patient = null;
        String sql = "SELECT * FROM Patients WHERE PatientID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    patient = new Patient(
                        rs.getInt("PatientID"),
                        rs.getString("PatientName"),
                        rs.getInt("Age"),
                        rs.getString("Gender"),
                        rs.getDate("AdmissionDate").toString(),
                        rs.getString("Ailment"),
                        rs.getString("AssignedDoctor")
                    );
                }
            }
        }
        return patient;
    }
    

    public List<Patient> getPatientsByDateRange(String fromDate, String toDate) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        String query = "SELECT * FROM Patients WHERE AdmissionDate BETWEEN ? AND ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                patients.add(mapResultSetToPatient(rs));
            }
        }
        return patients;
    }

    public List<Patient> getPatientsByAilment(String ailment) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        String query = "SELECT * FROM Patients WHERE Ailment = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, ailment);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                patients.add(mapResultSetToPatient(rs));
            }
        }
        return patients;
    }
    private Patient mapResultSetToPatient(ResultSet rs) throws SQLException {
        int patientID = rs.getInt("PatientID");
        String name = rs.getString("PatientName");
        int age = rs.getInt("Age");
        String gender = rs.getString("Gender");
        String admissionDate = rs.getString("AdmissionDate");
        String ailment = rs.getString("Ailment");
        String assignedDoctor = rs.getString("AssignedDoctor");

        return new Patient(patientID, name, age, gender, admissionDate, ailment, assignedDoctor);
    }
    public List<Patient> getPatientsByDoctor(String doctorName) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        String query = "SELECT * FROM Patients WHERE AssignedDoctor = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, doctorName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                patients.add(mapResultSetToPatient(rs));
            }
        }
        return patients;
    }
}
