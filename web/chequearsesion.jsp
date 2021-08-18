<%@ page session="true" %>
<%
    HttpSession sesionOk = request.getSession();
    sesionOk.setMaxInactiveInterval(300*6);
    if (sesionOk.getAttribute("usuario") == null ) 
    {
        clases.controles.connectSesion.close();
        response.sendRedirect("../login_sesion.jsp");
    }
%>