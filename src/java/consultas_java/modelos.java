 package consultas_java;

import clases.bdconexion1;
import clases.fuentedato;
import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import javax.servlet.http.*;  
import javax.servlet.*;  
import java.io.*;  
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
public class modelos  {  
public static   bdconexion1 conexion = new bdconexion1();
public static   fuentedato fuente = new fuentedato();
           
    public static String combo=""; 
    public static String combo_roles=""; 
    public static String combo_areas=""; 
    public static String combo_opciones=""; 
 
    public static void cargar_niveles()
        { try 
            {
            
                Connection cn = conexion.crearConexion();
                fuente.setConexion(cn);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_niveles");
                 while (rs.next()) 
                {
                    combo=combo+  "<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                }         
                rs.close();
                cn.close();
             } catch (Exception e) 
            {
                String as=e.toString();
            } 
        }
     public static void cargar_opciones()
        { try 
            {
                combo_opciones="";
                Connection cn = conexion.crearConexion();
                fuente.setConexion(cn);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_opciones_app");
                 while (rs.next()) 
                {
                    combo_opciones=combo_opciones+  "<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                }         
                rs.close();
                cn.close();
             } catch (Exception e) 
            {
                String as=e.toString();
            } 
        }
    public static void cargar_roles()
        { try 
            {   combo_roles="";
                Connection cn = conexion.crearConexion();
                fuente.setConexion(cn);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_roles");
                while (rs.next()) 
                {
                    combo_roles=combo_roles+"<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                }         
                rs.close();
                cn.close();
             } catch (Exception e) 
            {
                String as=e.toString();
            } 
        }        
    public static void cargar_areas()
        { try 
            {combo_areas="";
                Connection cn = conexion.crearConexion();
                fuente.setConexion(cn);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_areas where id_estado=7");
              
                while (rs.next()) 
                {
               combo_areas=combo_areas+  "<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                    
                }         
                rs.close();
                cn.close();
               
            } catch (Exception e) 
            {
                String as=e.toString();
            } 
        }        
    
 
    
   
    
    
  
}

 