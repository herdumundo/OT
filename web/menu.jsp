<!DOCTYPE html>
<html lang="es">
<%@ page session="true" %>
<%@include  file="chequearsesion.jsp" %>
<%    String usuario       = (String) sesionOk.getAttribute("usuario");
      String nivel = (String) sesionOk.getAttribute("desc_nivel");
      String rol = (String) sesionOk.getAttribute("desc_rol");
    
%>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
   <title>Grupo Maehara</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="estilos/css/sweetalert.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/styles_loading.css" rel="stylesheet">  
    <link href="estilos/css/bootstrap4-toggle.min.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/sb-admin-2.css" rel="stylesheet" type="text/css"/>
    <link href="lib/themes/main.css?v=1.0.2" rel="stylesheet" />
    <link href="lib/themes/default.css?v=1.0.2" rel="stylesheet" id="theme_base" />
    <link href="lib/themes/default.date.css?v=1.0.2" rel="stylesheet" id="theme_date" />
    <link href="estilos/css/colores.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/parpadeo.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/efecto_boton.css" rel="stylesheet" type="text/css"/>
      
    <link href="estilos/css/dataTables.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/select.dataTables.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/checkboxes.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/buttons.bootstrap4.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/DateTimePicker.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />
    <link href="estilos/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <link href="estilos/css/jquery-ui.multidatespicker.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.datatables.net/rowgroup/1.1.2/css/rowGroup.dataTables.min.css" rel="stylesheet" type="text/css"/>
     
    
</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">
     
    <ul class="navbar-nav bg-gradient-secondary sidebar sidebar-dark accordion toggled" id="accordionSidebar">
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3"> </div>
        </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item" onclick="traer_menu()">
    <a class="nav-link" >
      <i class="fas fa-fw fa-tachometer-alt"></i>
      <span>Principal</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        <%=usuario%>
      </div>

      
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
    <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul> 
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

    <!-- Topbar -->
    <nav class="navbar navbar-expand navbar-light bg-gradient-light topbar mb-4 fixed-top shadow">

      <!-- Sidebar Toggle (Topbar) -->
      <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
      </button>

      <!-- Topbar Search -->
      <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
          <a onclick="traer_menu()"><%=usuario%></a> 
      </form>

      <!-- Topbar Navbar -->
      <ul class="navbar-nav ml-auto">

     

        <!-- Nav Item - Alerts -->
        <li class="nav-item dropdown no-arrow mx-1"  id="notificacion">
          <a class="nav-link dropdown-toggle  " href="#"  id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-bell fa-fw "></i>
        <!-- Counter - Alerts -->
        <span class="badge badge-danger badge-counter">1</span>
          </a>
          <!-- Dropdown - Alerts -->
          <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
        <h6 class="dropdown-header bg-danger">
          Notificaciones
        </h6>
        <a class="dropdown-item d-flex align-items-center" >
          <div class="mr-3">
            <div class="icon-circle bg-danger">
              <i class="fas fa-file-alt text-white"></i>
            </div>
          </div>
          <div onclick="traer_pendiente_liberacion()" > 
              <div class="small text-gray-500" >Aviso</div>
            <span class="font-weight-bold">Cuenta con pendientes de aprobacion</span>
          </div>
        </a>
         
           </div>
        </li>

        <!-- Nav Item - Messages -->
       

        <div class="topbar-divider d-none d-sm-block"></div>

        <!-- Nav Item - User Information -->
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle"   id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=nivel%></span>
        <img class="img-profile rounded-circle" src="img/yemita.jpg">
         
          </a>
          <!-- Dropdown - User Information -->
          <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
         
           
          
        <div class="dropdown-divider"></div>
        <a class="dropdown-item"  data-toggle="modal" data-target="#logoutModal">
          <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
          Cerrar sesion
        </a>
          </div>
        </li>

      </ul>

    </nav>
    <br><br> <br>   
    <div  class="col-lg-12 mb-4">
        <div   id="contenido_row" class="row">
    
        </div>
        <div id="contenido"  >

        </div>
    </div>
      
    
    
    </div>
        
        
	
	 
      <!-- End of Main Content -->

      <!-- Footer -->
      
   
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->
 
  </div>
 
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
    <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">Preparado para salir?</h5>
      <button class="close" type="button" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">�</span>
      </button>
    </div>
    <div class="modal-body">Selecciona "Salir" si realmente desea terminar la sesion actual.</div>
    <div class="modal-footer">
      <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
      <a class="btn btn-primary" href="cerrarsesion.jsp">Salir</a>
    </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
    <script src="js/jquery-3.5.1.js" type="text/javascript"></script>
    <script src="js/dataTables.js" type="text/javascript"></script>
    <script src="js/dataTables.select.js" type="text/javascript"></script>
    <script src="estilos/js/checkboxes.js" type="text/javascript"></script>
    <script src="estilos/js/dataTables.buttons.js" type="text/javascript"></script>
    <script src="estilos/js/buttons.bootstrap4.min.js" type="text/javascript"></script>
    <script src="estilos/js/jszip.min.js" type="text/javascript"></script>
    <script src="estilos/js/pdfmake.min.js" type="text/javascript"></script>
    <script src="estilos/js/vfs_fonts.js" type="text/javascript"></script>
    <script src="estilos/js/buttons.html5.min.js" type="text/javascript"></script>
    <script src="estilos/js/buttons.print.min.js" type="text/javascript"></script>
    <script src="js/buttons.colVis.min.js.js" type="text/javascript"></script>
    <script src="estilos/js/dataTables.fixedHeader.min.js" type="text/javascript"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="js/sb-admin-2.min.js"></script>
    <script src="estilos/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="js/multiselect.js"></script>
    <script src="js/bootstrap4-toggle.js" type="text/javascript"></script>
    <script src="js/swetalert_net.js" type="text/javascript"></script>
    <script src="lib/picker.js?v=1.0.0"></script>
    <script src="lib/picker.date.js?v=1.1.0"></script>
    <script src="lib/legacy.js?v=1.1.0"></script>
    <script src="js/traer_clases.js?v=1.1.3" type="text/javascript"></script>
    <script src="js/grilla.js" type="text/javascript"></script>
    
   <!-- Custom scripts for all pages-->
   <script src="js/multi_select.js" type="text/javascript"></script>
   <script src="estilos/js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/rowgroup/1.1.2/js/dataTables.rowGroup.min.js" type="text/javascript"></script>
   
   
 
</body>
 <footer class="sticky-footer bg-gradient-light  ">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Registro Pedido de trabajo 2021 V.1.0</span>
          </div>
        </div>
    </footer>
</html>
