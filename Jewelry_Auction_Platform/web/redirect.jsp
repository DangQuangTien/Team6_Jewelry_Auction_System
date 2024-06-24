<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:set var="targetUrl" value="${targetUrl}" />
<c:if test="${empty targetUrl}">
    <c:set var="targetUrl" value="/home" />
</c:if>
<c:redirect url="${targetUrl}" />