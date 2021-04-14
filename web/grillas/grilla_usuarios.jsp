<%-- 
    Document   : grilla_pedidos_generados
    Created on : 07/04/2021, 04:26:35 PM
    Author     : hvelazquez
--%>
<%@include  file="../chequearsesion.jsp" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  try {  
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    String combo_nivel = (String) sesionOk.getAttribute("combo_nivel");
    String combo_areas = (String) sesionOk.getAttribute("combo_areas");    
    ResultSet rs = fuente.obtenerDato("select * from v_mae_ot_usuarios");
    int id=1;

         
     
%>
<table id="table_usuarios" class="table table-striped table-bordered" style="width:100%">
    <thead>
      <th >NOMBRE</th>   
      <th >USUARIO SISTEMA</th>   
      <th >CORREO</th>   
      <th >NIVEL</th>   
      <th >TIPO DE ACCESO</th>   
      <th >AREAS ASIGNADAS</th>   
      <th >ESTADO</th>   
      <th >CONTRASEÑA</th>   
      <th >EDITAR</th>   
       
     </thead>
    <tbody>
        <%
        while(rs.next()){
            id++; %>  
        <tr>  
            <td><%=rs.getString("nombre")%></td>
            <td><%=rs.getString("usuario")%></td>
            <td><%=rs.getString("correo")%></td>
            <td><select id="nivel<%=id%>"   class="form-control"    onchange="actualizar_nivel_usuario('<%=rs.getString("id_usuario")%>',$('#nivel'+<%=id%>).val(),'1');"   >  <%=combo_nivel%></select></td>
            <td><select id="rol<%=id%>"     class="form-control"    onchange="actualizar_nivel_usuario('<%=rs.getString("id_usuario")%>',$('#rol'+<%=id%>).val(),'2');"     > <%=consultas_java.modelos.combo_roles%></select></td>
            <td><select id="area<%=id%>"    class="form-control"    onchange=" $('#txt_areas_asignadas').val($('#area'+<%=id%>).val()) ;actualizar_areas_usuario($('#txt_areas_asignadas').val(),'<%=rs.getString("id_usuario")%>');" name="select_areas" required  multiple  data-live-search="true"> <%=combo_areas%></select></td>
            <td><select id="estado<%=id%>"  class="form-control"    onchange="actualizar_nivel_usuario('<%=rs.getString("id_usuario")%>',$('#estado'+<%=id%>).val(),'3');"  > <option value="7">ACTIVO</option><option value="8">INACTIVO</option></select></td>
            <td><input  type="button" class="btn form-control bg-primary color_letra" value="RESTABLECER CONTRASEÑA" onclick="restablecer_pass_usuario('<%=rs.getString("id_usuario")%>')"> </td>
            <td><input  type="button" class="btn form-control bg-warning color_letra" value="EDITAR DATOS" data-toggle="modal"  onclick="$('#txt_id_usuario').val('<%=rs.getString("id_usuario")%>');$('#txt_nombre').val('<%=rs.getString("first")%>');$('#txt_apellido').val('<%=rs.getString("last")%>');$('#txt_usuario').val('<%=rs.getString("usuario")%>');$('#txt_correo').val('<%=rs.getString("correo")%>')"  data-target="#modal_upd_user"> </td>
             
        </tr>
    <script>
        $("#nivel<%=id%>").val('<%=rs.getString("id_nivel")%>');
        $("#rol<%=id%>").val('<%=rs.getString("id_rol")%>');
        $("#estado<%=id%>").val('<%=rs.getString("id_estado")%>');
        $("#area<%=id%>").selectpicker();
    </script><%
        
        ResultSet rs2 = fuente.obtenerDato("SELECT   stuff(( select ','+  CONVERT(VARCHAR,[id_area]) "
                + "from mae_ot_det_areas with (nolock) where id_usuario = "+rs.getString("id_usuario")+" for XML path('') ),1,1,'')as areas");
          while(rs2.next())
          {
           %>   <script> var values = "<%=rs2.getString("areas")%>";
                    $('#area<%=id%>').val(values.split(','));
                    $('#area<%=id%>').selectpicker('refresh');
                </script><%   
          }

        
        }%>
    </tbody>
 </table>
    <%} 
catch (Exception e) {
String sa=e.toString();
     }%>

    