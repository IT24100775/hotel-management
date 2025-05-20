<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="content-section">
        <h2>Admin Logs</h2>
        <div class="logs-container">
            <table class="logs-table">
                <thead>
                    <tr>
                        <th>Timestamp</th>
                        <th>Action</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${logs}" var="log">
                        <tr>
                            <td>${log.timestamp}</td>
                            <td>${log.action}</td>
                            <td>${log.details}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<style>
.container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

.content-section {
    background: rgba(255, 255, 255, 0.25);
    border-radius: 18px;
    box-shadow: 0 4px 24px rgba(22, 123, 191, 0.10);
    padding: 30px;
    backdrop-filter: blur(8px) saturate(1.2);
    -webkit-backdrop-filter: blur(8px) saturate(1.2);
    border: 1.5px solid rgba(22, 123, 191, 0.13);
}

.logs-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.logs-table th,
.logs-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid rgba(22, 123, 191, 0.13);
}

.logs-table th {
    background: rgba(22, 123, 191, 0.10);
    color: #167bbf;
    font-weight: bold;
}

.logs-table tr:hover {
    background: rgba(22, 123, 191, 0.05);
}
</style>

<jsp:include page="../includes/footer.jsp" /> 