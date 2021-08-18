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
    //Connection cn = conexion.crearConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String id_usuario   = (String) sesionOk.getAttribute("id_usuario");
    String estado       = request.getParameter("estado");

    ResultSet rs,rs2,rs3;
    rs = fuente.obtenerDato("select * from v_mae_ot_usuarios where id_estado="+estado+"");
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
        <th >CORREOS DESTINATARIOS</th>   
        <th >CONTRASEÑA</th>   
        <th >EDITAR</th>   
    </thead>
    <tbody>
        <%
        while(rs.next())
        {
            id++; %>  
            <tr>  
                <td><%=rs.getString("nombre")%></td>
                <td><%=rs.getString("usuario")%></td>
                <td><%=rs.getString("correo")%></td>
                <td><select id="nivel<%=id%>"           class="form-control"    onchange="seleccionar_usuarios_correos('<%=rs.getString("id_usuario")%>',$('#nivel'+<%=id%>).val(),'select_correo<%=id%>');  "   >  <%=consultas_java.modelos.combo_niveles%></select></td>
                
                <td><select id="rol<%=id%>"             class="form-control"    onchange="actualizar_nivel_usuario('<%=rs.getString("id_usuario")%>',$('#rol'+<%=id%>).val(),'2');"     > <%=consultas_java.modelos.combo_roles%></select></td>
                
                <td><select id="area<%=id%>"            class="form-control"    onchange=" actualizar_areas_usuario('<%=rs.getString("id_usuario")%>','<%=id%>');" name="select_areas" required  multiple  data-live-search="true"> <%=consultas_java.modelos.combo_areas%></select></td>
                
                <td><select id="estado<%=id%>"          class="form-control"    onchange="actualizar_nivel_usuario('<%=rs.getString("id_usuario")%>',$('#estado'+<%=id%>).val(),'3');"  > <option value="7">ACTIVO</option><option value="8">INACTIVO</option></select></td>
                
                <td><select id="select_correo<%=id%>"   class="form-control"    onchange ="$('#txt_usuarios_correos_destinatarios').val($('#select_correo'+<%=id%>).val()); actualizar_correos_destinatarios('<%=rs.getString("id_usuario")%>',$('#txt_usuarios_correos_destinatarios').val(),$('#nivel'+<%=id%>).val());"    title="SIN DESTINATARIO"  multiple  data-live-search="true"> <%=consultas_java.modelos.combo_correos%></select></td>
                
                <td><input  type="button"               class="btn form-control bg-primary color_letra" value="RESTABLECER" onclick="restablecer_pass_usuario('<%=rs.getString("id_usuario")%>')"> </td>
                
                <td><input  type="button"               class="btn form-control bg-warning color_letra" value="EDITAR" data-toggle="modal"  onclick="$('#txt_id_usuario').val('<%=rs.getString("id_usuario")%>');$('#txt_nombre').val('<%=rs.getString("first")%>');$('#txt_apellido').val('<%=rs.getString("last")%>');$('#txt_usuario').val('<%=rs.getString("usuario")%>');$('#txt_correo').val('<%=rs.getString("correo")%>')"  data-target="#modal_upd_user"> </td>

            </tr>
            <script>
                $("#nivel<%=id%>").val('<%=rs.getString("id_nivel")%>');
                $("#rol<%=id%>").val('<%=rs.getString("id_rol")%>');
                $("#estado<%=id%>").val('<%=rs.getString("id_estado")%>');
                $("#area<%=id%>").selectpicker();
                $("#select_correo<%=id%>").selectpicker();
            </script><%
            rs2 = fuente.obtenerDato("SELECT   stuff(( select ','+  CONVERT(VARCHAR,[id_area]) "
                  + "from mae_ot_det_areas with (nolock) where id_usuario = "+rs.getString("id_usuario")+" for XML path('') ),1,1,'')as areas");
            while(rs2.next())
            {
             %>   <script> var values = "<%=rs2.getString("areas")%>";
                      $('#area<%=id%>').val(values.split(','));
                      $('#area<%=id%>').selectpicker('refresh');
                  </script><%   
            }

          rs3=fuente.obtenerDato("SELECT   stuff(( select ','+  CONVERT(VARCHAR,id_usuario_envio_correo)   "
             + "from mae_ot_correos_envio with (nolock) where id_usuario = "+rs.getString("id_usuario")+" and id_nivel="+rs.getString("ID_NIVEL")+"  for XML path('') ),1,1,'')as id_usuario");
            
            while(rs3.next())
            {
            %>   <script> var ids_correos = "<%=rs3.getString(1)%>";
                      $('#select_correo<%=id%>').val(ids_correos.split(','));
                      $('#select_correo<%=id%>').selectpicker('refresh');
                  </script><%  
              
            }      
        }%>
    </tbody>
     <tfoot>
            <tr>
               <th >NOMBRE</th>   
        <th >USUARIO SISTEMA</th>   
        <th >CORREO</th>   
        <th >NIVEL</th>   
        <th >TIPO DE ACCESO</th>   
        <th >AREAS ASIGNADAS</th>   
        <th >ESTADO</th>   
        <th >CORREOS DESTINATARIOS</th>   
        <th >CONTRASEÑA</th>   
        <th >EDITAR</th>   
            </tr>
        </tfoot>  
 </table>
    <%} 
catch (Exception e) {
String sa=e.toString();
     }%>

    