package consultas_java;
import clases.bdconexion1;
import clases.fuentedato;

import java.sql.Connection;
import java.sql.ResultSet;
public class modelos  
{  
    public static   bdconexion1 conexion = new bdconexion1();
    public static   fuentedato fuente = new fuentedato();
    public static String combo_niveles=""; 
    public static String combo_roles=""; 
    public static String combo_areas=""; 
    public static String combo_correos=""; 
    public static String combo_opciones=""; 
 
    public static String cargar_niveles()
    { try 
            {
                combo_niveles="";
               // Connection cn = conexion.crearConexion();
                fuente.setConexion(clases.controles.connectSesion);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_niveles");
                 while (rs.next()) 
                {
                    combo_niveles=combo_niveles+  "<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                }         
                rs.close();
                //cn.close();
                return combo_niveles;
             } catch (Exception e) 
            {
                String as=e.toString();
            } 
    return combo_niveles;
        }
    
    public static String cargar_opciones()
    { try 
            {
                combo_opciones="";
                //Connection cn = conexion.crearConexion();
                fuente.setConexion(clases.controles.connectSesion);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_opciones_app");
                 while (rs.next()) 
                {
                    combo_opciones=combo_opciones+  "<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                }         
                rs.close();
               // cn.close();
                return combo_opciones;
             } catch (Exception e) 
            {
                String as=e.toString();
            } 
    return null;
        }
    
    public static String cargar_roles()
    { try 
            {   combo_roles="";
                //Connection cn = conexion.crearConexion();
                fuente.setConexion(clases.controles.connectSesion);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_roles where id_estado=7");
                while (rs.next()) 
                {
                    combo_roles=combo_roles+"<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                }         
                rs.close();
              //  cn.close();
                return combo_roles;
             } catch (Exception e) 
            {
                String as=e.toString();
            } 
    return combo_roles;
        }        
    
    public static String cargar_areas()
    { try 
            {combo_areas="";
               // Connection cn = conexion.crearConexion();
                fuente.setConexion(clases.controles.connectSesion);
                ResultSet rs = fuente.obtenerDato("select * from mae_ot_areas where id_estado=7");
              
                while (rs.next()) 
                {
               combo_areas=combo_areas+  "<option value='"+rs.getString("id")+"'>"+rs.getString("descripcion")+"</option>";                    
                    
                }         
                rs.close();
               // cn.close();
               return combo_areas;
            } catch (Exception e) 
            {
                String as=e.toString();
            } 
    return null;
        }   

   public static String cargar_usuarios_correos()
    { try 
            {combo_correos="";
                //Connection cn = conexion.crearConexion();
                fuente.setConexion(clases.controles.connectSesion);
                ResultSet rs = fuente.obtenerDato("select * from  v_mae_ot_usuarios where correo <> '' and id_estado=7");
                while (rs.next()) 
                {
               combo_correos=combo_correos+  "<option value='"+rs.getString("id_usuario")+"'>"+rs.getString("nombre")+"</option>";                    
                    
                }         
                rs.close();
               // cn.close();
               return combo_correos;
            } catch (Exception e) 
            {
                String as=e.toString();
            } 
    return null;
        }    
 }

 