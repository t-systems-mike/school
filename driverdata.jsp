<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>

<html>
<head>
    <title>DriverData</title>

</head>
<body>
<h1>Driver Details</h1>

<table class="tg">
    <tr>
        <th width="80">ID</th>
        <th width="120">Name</th>
        <th width="120">Surname</th>
    </tr>
    <tr>
        <td>${driver.id}</td>
        <td>${driver.name}</td>
        <td>${driver.surname}</td>
    </tr>
</table>
</body>
</html>