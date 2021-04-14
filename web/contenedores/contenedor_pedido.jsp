<%-- 
    Document   : contenedor_pedido
    Created on : 06/04/2021, 02:32:21 PM
    Author     : hvelazquez
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    ResultSet rs,rs2;
%>
    <form id="form_pedido"> 
        <input type="checkbox"  data-toggle="toggle" data-on="LOGISTICA" data-off="MANTENIMIENTO" id="check_tipo_pedido" data-onstyle="success" data-offstyle="warning">
        <input type="hidden" value="1" id="tipo_pedido" name="tipo_pedido"/>
        <br><br>
        <div class="form-groupss" style="display:none" id="div_fecha_log" >
            <label class="form-control-placeholder"><b>Fecha necesaria</b></label>
            <input  style=" font-weight: bold"class="datepicker"  type="text" id="fecha_log" name="fecha_log">     
        </div>   
        <div class="form-groupss " >
            <label class="form-control-placeholder"><b>DESCRIPCION</b></label>
            <input name="descripcion" style="text-transform: uppercase;" autocomplete="off" id="descripcion" required  type="text" class="form-control" "placeholder="PROBLEMA">
        </div>        
        <br>
        <div class="form-groupss " >
            <label class="form-control-placeholder"><b>DETALLE DEL PROBLEMA</b></label>
            <textarea style="text-transform: uppercase;"  name = "detalle_problema" id="detalle_problema" required class="form-control"></textarea>
        </div>  
        <br>
        <div class="form-groupss " >
            <label class="form-control-placeholder"><b>ORIGEN</b></label>
            <select class="form-control" name="cbox_origen" id="cbox_origen" required onchange="filtro_maquina();" >
                    <OPTION value="" disabled selected="selected">SELECCIONE EL ORIGEN</OPTION>
                    <%rs2 = fuente.obtenerDato("select c.id, c.descripcion from mae_ot_usuario a inner join mae_ot_det_areas b on a.id=b.id_usuario "
                            + " inner join mae_ot_areas c on b.id_area=c.id where a.id="+id_usuario+" and a.id_estado=7");
                    while(rs2.next())
                    {
                    %> <OPTION value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></OPTION>  <%}%>
                </select> 
        </div>  
        <br>
        <div  id= "div_proveedor" >
            <div class="form-groupss " >
                <label class="form-control-placeholder"><b>MAQUINA</b></label>
                <select class="form-control" name="cbox_maquina" id="cbox_maquina" required onchange="filtro_subcat();">
                    
                </select>
            </div>  
            <br> 
            <div class="form-groupss " >
                <label class="form-control-placeholder"><b>COMPONENTES MAQUINA</b></label>
                 <select id="id_categoria" name="id_categoria"  required class="form-control">
                
                </select>
            </div>  
            <br>
            <div class="form-groupss " >
                <label class="form-control-placeholder"><b>TIPO DE PROBLEMA</b></label>
                <select class="form-control" name="cbox_tipo_problem" id="cbox_tipo_problem" required>
                <OPTION value="" disabled selected="selected">SELECCIONE TIPO DE PROBLEMA</OPTION>
                    <%rs = fuente.obtenerDato("select * from mae_ot_tipo_problema");
                    while(rs.next())
                    {
                    %> <OPTION value="<%=rs.getString(1)%>"><%=rs.getString(2)%></OPTION>  <%}%>
                </select> 
                
            </div> 
                <br>
                 <input type="submit" value="Registrar" id="btn_registrar" name="btn_registrar" class="form-control btn btn-info "/>
               
        </div> 
    </form>