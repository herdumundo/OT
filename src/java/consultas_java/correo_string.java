 package consultas_java;


import java.io.*;  
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
public class correo_string  {  

  private   String codigo;
    private   String nombre; 


    public correo_string(String codigo, String nombre ) {
        this.codigo = codigo;
        this.nombre = nombre;
       
     }

    public correo_string(){

    }

    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

 

    public String getcodigo() {
        return codigo;
    }

    public void setcodigo(String codigo) {
        this.codigo = codigo;
    }




}
