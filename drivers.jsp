<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <title>Drivers information</title>
</head>
<body>
<a href="../../index.jsp">Back to login</a>
<br/>
<br/>

<h1>Drivers List</h1>

<c:if test="${!empty listDrivers}">
    <table class="tg">
        <tr>
            <th width="80">ID</th>
            <th width="120">Name</th>
            <th width="120">Surname</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listDrivers}" var="driver">
            <tr>
                <td>${driver.id}</td>
                <td><a href="/driverdata/${driver.id}" target="_blank">${driver.name}</a></td>
                <td>${driver.surname}</td>
                <td><a href="<c:url value='/edit/${driver.id}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${driver.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>