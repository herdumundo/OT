<%-- 
    Document   : contenedor_pendientes
    Created on : 12/04/2021, 11:57:11 AM
    Author     : hvelazquez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<div id="div_fechas" style="display: none">
    
    
            <br><br>
            <a>INGRESAR FECHA DESDE</a>
            <input id="fecha_desde"  name="fecha_desde" class="datepicker" data-format="dd/mm/yyyy"  width="276"   />
            <a>INGRESAR FECHA HASTA</a>
            <input id="fecha_hasta" name="fecha_hasta" class="datepicker" data-format="dd/mm/yyyy"  width="276"  />
    <br><br>
    <input type="button" value="BUSCAR" class="form-control bg-gradient-primary color_letra" onclick="ir_grilla_pedidos_general();">
    <br><br>    
 </div>


<div id="div_table_pendientes">
    
    
</div>

