<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--<jsp:useBean id="pagedListHolder" scope="request" class="org.springframework.beans.support.PagedListHolder" /> --%>
<%-- <% --%>
  <%-- // int p = 0;
    //pagedListHolder.setPageSize(8);
    //pagedListHolder.setPage(p);
    --%>
<%-- %> --%>
<%-- // use our pagedListHolder --%>



<%-- // create link for pages, "~" will be replaced  later on with the proper page number --%>

<%-- // load our paging tag, pass pagedListHolder and the link --%>
<tg:paging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Employees List</title>
    <!-- Bootstrap CSS -->
    <%-- <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet"> --%>
  <!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> -->

    <style> <%@include file="/resources/css/bootstrap.min.css" %> </style>

    <style type="text/css">
        .myrow-container {
            margin: 20px;
        }

        .paging-font{
            font-size: 20px;
        }
        .paging-nav {
            text-align: center;
            padding-top: 2px;
        }

        .paging-nav a {
            margin: auto 1px;
            text-decoration: none;
            display: inline-block;
            padding: 1px 7px;
            background: #91b9e6;
            color: white;
            border-radius: 3px;
        }

        .paging-nav .selected-page {
            background: #187ed5;
            font-weight: bold;
        }

        .paging-nav,
        #tableData {
            width: 400px;
            margin: 0 auto;
            font-family: Arial, sans-serif;
        }
    </style>
    <%--/src/main/webapp/resources/js  = ${pageContext.request.contextPath}/resources/js --%>




</head>

<body class=".container-fluid">
<div class="container myrow-container">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">
                <div align="left"><a href ="getAllEmployees"><b>Employees List</b></a></div>
                <div align="right"><a href="createEmployee">Add New Employee</a></div>
            </h3>
        </div>
        <div class="panel-body">



                <form action="searchEmployee">
                    <div class="row">
                        <div class="col-md-4">Search Employees: <input type='text' name='searchName' id='searchName'/> </div>
                        <div class="col-md-4"><input class="btn btn-success" type='submit' value='Search'/></div>
                    </div>
                </form>


            <c:if test="${not empty allEmployeesSearch}">

                <table  class="table table-hover table-bordered">
                    <thead style="background-color: #bce8f1;">
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Salary</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${allEmployeesSearch}" var="emp">
                        <tr>
                            <th><c:out value="${emp.id}"/></th>
                            <th><c:out value="${emp.name}"/></th>
                            <th><c:out value="${emp.age}"/></th>
                            <th><c:out value="${emp.salary}"/></th>
                            <th><a href="editEmployee?id=<c:out value='${emp.id}'/>">Edit</a></th>
                            <th><a href="deleteEmployee?id=<c:out value='${emp.id}'/>">Delete</a></th>
                        </tr>
                    </c:forEach>

                        <%--   <tr>
                               <td colspan="5" align="center">
                                   <a href="?page=prev">Prev</a>
                                   <a href="?page=next"> Next</a>

                           </tr> --%>
                        <%-- <div id="pagination"> --%>
                    <div class="paging-font" align="center">

                        <c:url value="/searchEmployee" var="prev">
                            <c:param name="page" value="${page-1}"/>
                        </c:url>
                        <c:if test="${page > 1}">
                            <a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
                        </c:if>

                        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                            <c:choose>
                                <c:when test="${page == i.index}">
                                    <span>${i.index}</span>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/searchEmployee" var="url">
                                        <c:param name="page" value="${i.index}"/>
                                    </c:url>
                                    <a href='<c:out value="${url}" />'>${i.index}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:url value="/searchEmployee" var="next">
                            <c:param name="page" value="${page + 1}"/>
                        </c:url>
                        <c:if test="${page + 1 <= maxPages}">
                            <a href='<c:out value="${next}" />' class="pn next">Next</a>
                        </c:if>
                    </div>

                    </tbody>
                </table>
            </c:if>


                <%-- // load our paging tag, pass pagedListHolder and the link --%>
                <tg:paging pagedListHolder="${pagedListHolder}" pagedLink="${pagedLink}"/>


        </div>
    </div>
</div>
</body>
</html>