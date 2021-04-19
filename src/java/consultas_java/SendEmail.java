package consultas_java;


import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author hvelazquez
 */
public class SendEmail {
 
  public static String doSomething() {
    // do something and generate a String
    return "helloWord";
  }
 
   
  public static void enviarCorreo(String descripcion,String detalle ,String correo){
       try {
            
           final String[] testEmailNames = correo.split(",");
           

                String host = "smtp.gmail.com";
                String de = "notificacionespedidosmaehara@gmail.com";
                String clave ="gm$123456";
                
                Properties prop = System.getProperties();
                
                prop.put("mail.smtp.starttls.enable","true");
                prop.put("mail.smtp.host", host);
                prop.put("mail.smtp.user",de);
                prop.put("mail.smtp.password", clave);
                prop.put("mail.smtp.port","587");
                prop.put("mail.smtp.auth","true");
                
                Session sesion = Session.getDefaultInstance(prop,null);
                
                MimeMessage message = new MimeMessage(sesion);
                
                message.setFrom(new InternetAddress(de));
                
               
                   // NOTA: para enviar correo electronico masivo
                
                    InternetAddress[] direcciones = new InternetAddress[testEmailNames.length];
                    for(int i=0;i<testEmailNames.length;i++){
                        direcciones[i] = new InternetAddress(testEmailNames[i]);
                    }
                    for(int i=0;i<direcciones.length;i++){
                        message.addRecipient(Message.RecipientType.TO, direcciones[i]);
                    }
              
                
                //message.setRecipient(Message.RecipientType.TO, new InternetAddress(correo));
                
                message.setSubject("Pedido de trabajo: "+descripcion);
                message.setText(detalle);
                
                Transport transport = sesion.getTransport("smtp");
                
                transport.connect(host,de,clave);
                
                transport.sendMessage(message, message.getAllRecipients());
                
                transport.close();
                return;
              } catch (Exception e) {
                  
        }   
    }
     
     
}