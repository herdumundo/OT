var ruta_contenedores="./contenedores/";
var cruds="./cruds/";
var ruta_grillas="./grillas/";
var ruta_consultas="./consultas/";
var direccion="1";
 $(document).ready(function()
{
   no_volver_atras();
    traer_menu();
    
});
   
    function no_volver_atras(){
 
    (function (global) { 

    if(typeof (global) === "undefined") {
        throw new Error("window is undefined");
    }

    var _hash = "!";
    var noBackPlease = function () {
        global.location.href += "#";

        // making sure we have the fruit available for juice (^__^)
        global.setTimeout(function () {
            global.location.href += "!";
        }, 50);
    };

    global.onhashchange = function () {
        if (global.location.hash !== _hash) {
            global.location.hash = _hash;
        }
    };

    global.onload = function () {            
        noBackPlease();

        // disables backspace on page except on input fields and textarea..
        document.body.onkeydown = function (e) {
            var elm = e.target.nodeName.toLowerCase();
            if (e.which === 8 && (elm !== 'input' && elm  !== 'textarea')) {
                e.preventDefault();
            }
            // stopping event bubbling up the DOM tree..
            e.stopPropagation();
        };          
    };

})(window);
}
    
    function navegar_paginas(){
      
      if(direccion=="1"){
          traer_menu();
      }
      else if (direccion=="2"){
          ir_panel();
      }
      //alert(direccion);
  }
    
    function onclickMenu()
    {
        $('#div_registro_pedido').click(function(){
            ir_pedido();
        });
        $('#div_pendientes_generados').click(function(){
            ir_pedidos_generados();
        });

        $('#div_panel').click(function(){
            ir_panel();
        });

        $('#div_pendientes_aprobaciones_ja').click(function(){
            ir_contenedor_pendientes_aprobaciones("grilla_pendientes_ja.jsp");
        });

        $('#div_pendientes_aprobaciones_jm').click(function(){
            ir_contenedor_pendientes_aprobaciones("grilla_pendientes_jm.jsp");
        });
        $('#div_pendientes_aprobaciones_em').click(function(){
            ir_contenedor_pendientes_aprobaciones("grilla_pendientes_em.jsp");
        });
        $('#div_pendientes_resoluciones').click(function(){
            ir_contenedor_pendientes_aprobaciones("grilla_pendientes_resolucion.jsp");
        });
        $('#div_pendientes_verificacion').click(function(){
            ir_contenedor_pendientes_aprobaciones("grilla_pendientes_verificacion.jsp");
        });
        
        $('#div_pass').click(function(){
            actualizar_pass();
        }); 
         
        $('#div_pendientes_todos').click(function(){
           ir_contenedor_pendientes("grilla_pendientes_todos.jsp",1);
        });
        
        $('#div_pendientes_estado').click(function(){
           ir_contenedor_pendientes("grilla_pedidos_general.jsp",2);
        });
    }
  
    function traer_menu()
    {
        $.ajax({
                type: "POST",
                url: ruta_contenedores+'contenedor_menu.jsp',
             beforeSend: function() 
             {
            $('#contenido').html("");          
                },           
            success: function (res) 
            {
                $("#contenido_row").html(res);
                $("#modalx-flipOut_wrapper").remove();
                $("#modal_submaq_background").remove();
                $("#modalx-flipOut_background").remove();
                $("#modal_submaq_wrapper").remove();
                $("#modal_vinculacion_background").remove();
                $("#modal_vinculacion_background").remove();
                $("#modal_vinculacion_wrapper").remove();
                
                $('#contenido_row').show();
             onclickMenu();
             
            }
                });  
    }
    
    function ir_pedido()
    {
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_pedido.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            $('#check_tipo_pedido').bootstrapToggle();
            cargar_toggles();
            $('#form_pedido').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_pedido();
                event.stopPropagation();
            }); 
                
            }
                });      
      }        
   
    function ir_creacion_usuarios()
    {
        direccion="2";
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_crear_usuario.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            $("#div_areas").css('background-color','LemonChiffon');  
            cargar_usuario_combo();
         
                 

            ir_grilla_usuarios('7');
             $('#form_add_user').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_usuario();
                event.stopPropagation();
            }); 
            
               $('#form_upd_user').on('submit', function(event)
            {    
                event.preventDefault();
                actualizar_usuario();
                event.stopPropagation();
             }); 
        
        }
                });      
     }    
     
    function ir_creacion_maquinas()
    {
        direccion="2";
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_crear_maquinas_sub.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            
            $('#modalx-flipOut').popup({
                pagecontainer: '.container',
                transition: 'all 0.3s',
                color: '#000'
            }); 
                    
            $('#modal_submaq').popup({
                pagecontainer: '.container',
                transition: 'all 0.3s',
                color: '#000'
		    });
            $('#modal_vinculacion').popup({
                pagecontainer: '.container',
                transition: 'all 0.3s',
                color: '#000'
		    })
            $('#select_areas').selectpicker();  
            
                
            $('#form_add_maquina').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_maquina();
                event.stopPropagation();
            }); 
              $('#form_add_subcat').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_subcategoria();
                event.stopPropagation();
            });  
               $('#form_add_vinculacion').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_vinculacion_subcategorias();
                event.stopPropagation();
            }); 
            
          //  ir_grilla_maquina_subcategoria();
        }
        
                });      
     }   
     
    function ir_creacion_tipos_problemas()
    {
        direccion="2";
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_crear_tipos_problemas.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            
            listar_grilla_tipo_problema();
        }
        
                });      
     }     
    function ir_creacion_proveedores()
    {
        direccion="2";
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_crear_proveedores.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            
            ir_grilla_proveedores();
            $('#form_add_proveedor').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_proveedor();
                event.stopPropagation();
            }); 
            
               $('#form_upd_proveedor').on('submit', function(event)
            {    
                event.preventDefault();
                 actualizar_proveedor();
                event.stopPropagation();
            }); 
            
            
          
        }
                });      
     }   
    
    function ir_creacion_roles_areas()
    {
        direccion="2";
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_crear_roles_areas.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            $("#div_areas").css('background-color','LemonChiffon');  
           
            //ir_grilla_usuarios();
             $('#form_add_rol').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_rol();
                event.stopPropagation();
            }); 
            $('#form_add_area').on('submit', function(event)
            {    
                event.preventDefault();
                registrar_area();
                event.stopPropagation();
            }); 
            
              $('#form_add_vinculacion_rol').on('submit', function(event)
            {    
                event.preventDefault();
                actualizar_opciones_roles();
                event.stopPropagation();
            });
          $('#select_opciones').selectpicker();
          
        }
                });      
     }   
    
    function ir_pedidos_generados()
    {
        $.ajax({
        type: "POST",
        url: ruta_grillas+'grilla_pedidos_generados.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            $('#table_generados').DataTable({"scrollX": true,"pageLength": 100});
            
        }
                });      
    }  
    
    function ir_creacion_operarios()
    {
        direccion="2";
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_crear_operarios.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            ir_grilla_operarios();
           
             $('#form_upd_operario').submit(function(evt){
                
                evt.preventDefault();
                        actualizar_operario();      
                evt.stoppropagation();

             });
             $('#form_add_operario').submit(function(evt){
                
                evt.preventDefault();
                        registrar_operario();      
                evt.stoppropagation();

             });
        }
                });      
    }
  
    function ir_grilla_operarios(){
       $.get(ruta_grillas+'grilla_operarios.jsp',  function(res)
                {
                    $("#grilla_operarios").html(res);
                    $("#table_operarios").DataTable();
                    
                    
                 } ); 
      
  }
    
    function ir_panel(){
     direccion="1";
    $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_menu_panel.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
            $('#contenido').html('');

        },           
        success: function (res) 
        {
            $('#contenido_row').html(res);
            
            
        }
                });      
  }
  
    function ir_contenedor_pendientes_aprobaciones(tipo_aprobacion,pagina){
    $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_pendientes.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
            $('#contenido').html('');

        },           
        success: function (res) 
        {
            $('#contenido').html(res);
       
            ir_grilla_pendiente_aprobaciones(tipo_aprobacion,pagina);
        }
                });      
  }
    
    function ir_grilla_pedidos_general(){
       $("#div_table_pendientes").html('');
       $('#loading_cubo').show();
       
         $.get(ruta_grillas+'grilla_pedidos_general.jsp',({desde:$('#fecha_desde').val(),hasta:$('#fecha_hasta').val()}), function(res)
                {
                    $('#loading_cubo').hide();
                    
                    $("#div_table_pendientes").html(res);
                    activar_datatable_pendientes();
                } );   
   }
    
    function ir_contenedor_pendientes(pagina,tipo)
    {
        $.ajax({
        type: "POST",
        url: ruta_contenedores+'contenedor_pendientes.jsp',
        beforeSend: function() 
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
            $('#contenido').html('');

        },           
        success: function (res) 
        {
            $('#contenido').html(res);
            if(tipo==1)
            {
                $.get(ruta_grillas+pagina, function(res)
                {
                    $("#div_table_pendientes").html(res);
                    activar_datatable_pendientes();
                } );            
            }
            else
            {
                $("#div_fechas").show();
                cargar_estilo_calendario();
            }
           
        }
                });      
    } 
    
    function ir_grilla_pendiente_aprobaciones(pagina)
    {
        $.get(ruta_grillas+pagina, function(res)
        {
            $("#div_table_pendientes").html(res);
            $("#table_pendientes").DataTable({
            scrollY:        "500px",
            scrollX:        true,
            dom: 'Bfrtip',
            "pageLength": 100,
       
            "language": {
                "sSearch":         "Buscar:",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ning??n dato disponible en esta tabla",
                "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
            "oPaginate": {
                            "sFirst":    "Primero",
                            "sLast":     "??ltimo",
                            "sNext":     "Siguiente",
                            "sPrevious": "Anterior"
                        }, 
             //  "sUrl": "js/Spanish.txt" ,
               buttons: {
                copyTitle: 'DATOS COPIADOS',
                copySuccess: {
                    _: '%d FILAS COPIADAS' 
                }
            }  
        },
         buttons: [
            {
                extend: 'copyHtml5',
                text: 'COPIAR GRILLA',
                exportOptions: {
                columns: [ 0, ':visible' ]
                    }
            },
            {
                extend: 'excelHtml5',
                title:'INFORME PEDIDOS',                
                text: 'EXCEL',
                     
            
                exportOptions: {
                    columns: ':visible'
                }
            },
            {
                extend: 'pdfHtml5',
                text: 'PDF',
                title: 'INFORME PEDIDOS',
                orientation: 'landscape',
                pageSize: 'LEGAL',
                customize: function(doc) {
                  
                    doc.styles.title = {
                      color: 'white',
                      fontSize: '20',
                      background: 'black',
                      alignment: 'center'
                      
                    }
                    doc.styles.tableHeader = {
                       fontSize: '6'
                    }
                    doc.styles.tableBodyEven = {
                      fontSize: '6'
                    }
                    doc.styles.tableBodyOdd = {
                       fontSize: '6'
                    }
                   doc.styles.tableFooter = {
                       fontSize: '6'
                    }
                   doc.styles['td:nth-child(2)'] = { 
                      width: '100px',
                      'max-width': '100px'
                    }
                  }   ,
                exportOptions: {
                    columns: ':visible'
                 }
            },
            'colvis'
        ], keys: {
        clipboard: false
        }});
            });    
        }
    
    function cargar_toggles() 
    {
        $('#check_tipo_pedido').change(function () 
        {
            if ($(this).prop("checked") == true) 
            {
                $('#tipo_pedido').val('2');
            }
            else 
            {
                $('#tipo_pedido').val('1');
            }
        });
    
         
    }
 
    function filtro_maquina()
    {
        $.get(ruta_consultas+'consulta_maquinas.jsp',{id_area:$("#cbox_origen").val()},function(res)
        {
            $("#cbox_maquina").html(res.cbox_maquina);
        });
    }   
    
    function cargar_usuario_combo()
    {
        $.get(ruta_consultas+'consulta_usuarios.jsp', function(res)
        {
            $("#cbox_multi_usuario").html(res.cbox_usuario);
            $('#cbox_multi_usuario').selectpicker();
        });
    }   
    
    function cargar_rol()
    { 
        $('#select_opciones').selectpicker('val', '');
        $.get(ruta_consultas+'consulta_roles.jsp', function(res)
        {
            $("#cbox_rol").html(res.cbox_roles);
        });
    }
    function ir_grilla_usuarios(estado)
    {
        $.get(ruta_grillas+'grilla_usuarios.jsp',({estado:estado}), function(res)
        {
            $("#grilla_usuarios").html('');
            $("#grilla_usuarios").html(res);
           
             //   $('#table_usuarios thead tr').clone(true).appendTo( '#table_usuarios thead' );
                $('#table_usuarios thead tr:eq(0) th').each( function (i) 
                {
                    var title = $(this).text();
                    
                    if(i<=2)
                    {
                        $(this).html( '<input type="text" placeholder="'+title+'" />' );
                        $( 'input', this ).on( 'keyup change', function () 
                        {
                            if ( table.column(i).search() !== this.value ) 
                            {
                                table.column(i).search( this.value ).draw();
                            }
                        } );
                    }
                } );
                
                var table = $('#table_usuarios').DataTable({
                            dom: 'Pfrtip',
                            "pageLength": 50,
                            //scrollY:        "500px",
                            scrollX:        true,
                            "ordering": false 
    
                      });
                 $('.dataTables_filter').hide(); 
        });
    }      
      
    function ir_grilla_proveedores()
    {
        $.get(ruta_grillas+'grilla_proveedores.jsp', function(res)
        {
            $("#grilla_proveedores").html('');
            $("#grilla_proveedores").html(res);
            $("#table_proveedores").DataTable({ "pageLength": 100});
            
        });
    }
    function filtro_subcat()
    {
        $.get(ruta_consultas+'consulta_subcat.jsp',{id_maquina:$("#cbox_maquina").val()},function(res)
        {
            $("#id_categoria").html(res.cbox_subcat);
        });
    } 
     function cargar_subcat()
    {
        $.get(ruta_consultas+'consulta_subcat_vinc.jsp',{id_maquina:'VINCULACION'},function(res)
        {
            $("#select_submaq_vinc").html('');
            $("#select_submaq_vinc").html(res.cbox_subcat);
            $('#select_submaq_vinc').selectpicker();  
        });
    } 
    function ir_grilla_areas()
    {
        $.get(ruta_grillas+'grilla_areas.jsp', function(res)
        {
            $("#div_table_area").html(res);
            $('#table_areas').DataTable({ "pageLength": 100,});
        });
    } 
    
     function ir_grilla_maquinas()
    {
        $('#select_areas').selectpicker('val', '');
        $.get(ruta_grillas+'grilla_maquinas.jsp', function(res)
        {
            $("#div_grilla_maquina").html(res);
            $('#table_maquinas').DataTable();
        });
    }
    
     function ir_grilla_subcategoria()
    {
        $.get(ruta_grillas+'grilla_subcategoria.jsp', function(res)
        {
            $("#div_grilla_subcat").html(res);
            $('#table_subcat').DataTable();
        });
    }
    
    function ir_grilla_maquina_subcategoria(id_maquina)
    {
        $.get(ruta_grillas+'grilla_maquinas_subcategorias.jsp',({id_maquina:id_maquina}) ,function(res)
        {
            $("#grilla_maquinas_subcategorias").html(res);
            $('#table_maquina_subcategoria').DataTable();
        });
    } 
    
    function listar_grilla_tipo_problema()
    {
        $.get(ruta_grillas+'grilla_tipos_problemas.jsp', function(res)
        {
            $("#grilla").html(res);
            $('#table_tipo_problema').DataTable({ "pageLength": 100,});
        });
    } 
    
    function ir_grilla_roles()
    {
        $.get(ruta_grillas+'grilla_roles.jsp', function(res)
        {
            $("#div_table_rol").html(res);
            $('#table_rol').DataTable();
        });
    }
    function registrar_pedido(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA REGISTRAR LOS DATOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_ot.jsp',
                data: $("#form_pedido").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_ot(res.tipo_respuesta,res.mensaje)            
            }
                });
               
                
            }
    }); 
   }
    
    function registrar_usuario(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO USUARIO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_usuario.jsp',
                data: $("#form_add_user").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_user(res.tipo_respuesta,res.mensaje)  ;          
            }
                });
               
                
            }
    }); 
   }
 
    function registrar_maquina(){
      $('#ids_areas').val($('#select_areas').val());
       
         Swal.fire({
           target: document.getElementById('modalx-flipOut') ,       
            title: 'CONFIRMACION',
        text: "DESEA CREAR LA MAQUINA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_maquina.jsp',
                data: $("#form_add_maquina").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                         target: document.getElementById('modalx-flipOut'),
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                 aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,'modalx-flipOut',"1")  ;          
            }
                });
            }
    });  
   }
   
    function registrar_subcategoria(){
        
         Swal.fire({
        target: document.getElementById('modal_submaq') ,       
        title: 'CONFIRMACION',
        text: "DESEA CREAR LA SUBCATEGORIA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_subcategoria.jsp',
                data: $("#form_add_subcat").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                         target: document.getElementById('modal_submaq'),
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                 aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,'modal_submaq',"2")  ;          
            }
                });
            }
    });  
   }
   
    function registrar_vinculacion_subcategorias(){
        $('#id_vinculaciones_subcat').val($('#select_submaq_vinc').val()) ;

        Swal.fire({
        target: document.getElementById('modal_vinculacion') ,       
        title: 'CONFIRMACION',
        text: "DESEA CREAR LA VINCULACION?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_vincular_subcat_maquinas.jsp',
                data: $("#form_add_vinculacion").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    target: document.getElementById('modal_vinculacion'),
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                 aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,'modal_vinculacion',"3")  ;           
            }
                });
            }
    });  
   }
   
    function eliminar_maquina(id){
        
         Swal.fire({
           target: document.getElementById('modalx-flipOut') ,       
            title: 'CONFIRMACION',
        text: "DESEA ELIMINAR LA MAQUINA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, ELIMINAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_eliminar_maquinas.jsp',
                data: ({id:id}),
                beforeSend: function() 
                {
                    Swal.fire({
                    target: document.getElementById('modalx-flipOut'),
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                
                aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,'modalx-flipOut',"2")  ;          
                var table = $('#table_maquinas').DataTable();
                table.row('#'+id).remove().draw( false );
            }
                });
               
                
            }
    });  
   }
    
    function editar_maquinas_submaq(id,descripcion,modal,procedure,condicion){
        var html="<form id='form_editar' action='POST'>\n\
                    <input type='hidden'     name='txt_edit_id' id='txt_edit_id' value='"+id+"'> \n\
                    <input type='hidden'     name='modal_id' id='modal_id' value='"+modal+"'> \n\
                    <input type='hidden'     name='procedure' id='procedure' value='"+procedure+"'> \n\
                    <input type='hidden'     name='condicion' id='condicion' value='"+condicion+"'> \n\
                    <input type='text'  required  name='txt_edit_descripcion' id='txt_edit_descripcion' value='"+descripcion+"'> \n\
                  <br><br><input type='submit' class='form-control btn btn-success envio'    value='EDITAR' > \n\
                  </form>";
        
      Swal.fire({
            target: document.getElementById(modal),
            title: 'EDITAR DATOS',
            html: html,
            type: 'warning',
             confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            showCancelButton: false,
            showConfirmButton: false
                    });
          //  $(document).on('click','.envio',function(){
            $('#form_editar').submit(function(evt){
                
                evt.preventDefault();
               var mod= $('#modal_id').val();// to stop form submitting
               var cond=$('#condicion').val();;// to stop form submitting
                $.ajax({
                type: "POST",
                url: cruds+"control_actualizar_maquina_subcat.jsp",
                data: $("#form_editar").serialize() ,
                beforeSend: function() {
                Swal.fire({
                target: document.getElementById(modal),
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                            .textContent = Swal.getTimerLeft()
                    }, 1000); }
                        }); 
                     },           
                success: function (res) 
                {
                    aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,mod,cond)  ;                 
                
                } 
                        }); 
              evt.stoppropagation();
            });
        //}); 
   }
   
    function aviso_registro_maquina_sub(tipo,mensaje,modal,condicion){
       if(tipo=="1"){
        swal.fire({
            target: document.getElementById(modal),
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });
             if(condicion=="1"){
                ir_grilla_maquinas();
                $('#ids_areas').val("");
                $('#maquina').val("");
                $('#select_areas').selectpicker('val', '');

             }   
            else if(condicion=="2"){
                ir_grilla_subcategoria();
                $('#subcat').val("");              
             } 
            else if(condicion=="3"){
                ir_grilla_maquina_subcategoria($('#cbox_maquina').val());
              //  $('#cbox_origen').prop('selectedIndex',0);
               // $('#cbox_maquina').html('');
                $('#select_submaq_vinc').selectpicker('val', '');
             }
            else if(condicion=="4"){
          
             }
            else if(condicion=="5"){
                ir_grilla_maquinas();
             }
            else if(condicion=="6"){
                ir_grilla_subcategoria();
             }
       }
     
       else {
          
           swal.fire({
                target: document.getElementById(modal),
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
        
   }
   
    function editar_tipo_problema(id,descripcion){
        var html="<form id='form_editar' action='POST'>\n\
                    <input type='hidden'     name='txt_edit_id' id='txt_edit_id' value='"+id+"'> \n\
                    <input type='text'  required  name='txt_edit_descripcion' id='txt_edit_descripcion' value='"+descripcion+"'> \n\
                  <br><br><input type='submit' class='form-control btn btn-success envio'    value='EDITAR' > \n\
                  </form>";
        
      Swal.fire({
            title: 'EDITAR DATOS',
            html: html,
            type: 'warning',
             confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            showCancelButton: false,
            showConfirmButton: false
                    });
           // $(document).on('click','.envio',function(){
            $('#form_editar').submit(function(evt){
                
                evt.preventDefault();
                $.ajax({
                    type: "POST",
                    url: cruds+"control_actualizar_tipo_problema.jsp",
                    data: $("#form_editar").serialize() ,
                    beforeSend: function() {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: '<strong>ESPERE</strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft()
                        }, 1000); }
                            }); 
                         },           
                    success: function (res) 
                    {
                        aviso_registro_tipo_problema(res.tipo_respuesta,res.mensaje,'2')  ;                 

                    } 
                        }); 
              evt.stoppropagation();
            });
      //  }); 
   } 
  
    function eliminar_tipo_problema(id){
        var html="<form id='form_editar' action='POST'>\n\
                    <input type='hidden'     name='txt_edit_id' id='txt_edit_id' value='"+id+"'> \n\
                     <br><br><input type='submit' class='form-control btn btn-danger envio'    value='ELIMINAR' > \n\
                  </form>";
        
      Swal.fire({
            title: 'DESEA ELIMINAR EL TIPO DE PROBLEMA?',
            html: html,
            type: 'warning',
             confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            showCancelButton: false,
            showConfirmButton: false
                    });
          //  $(document).on('click','.envio',function(){
            $('#form_editar').submit(function(evt){
                
                evt.preventDefault();
                $.ajax({
                    type: "POST",
                    url: cruds+"control_eliminar_tipo_problema.jsp",
                    data: $("#form_editar").serialize() ,
                    beforeSend: function() {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: '<strong>ESPERE</strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft()
                        }, 1000); }
                            }); 
                         },           
                    success: function (res) 
                    {
                        aviso_registro_tipo_problema(res.tipo_respuesta,res.mensaje,'2')  ;                 
                        $('#form_editar').unbind('submit');                 
                    
                    } 
                        }); 
              evt.stoppropagation();
            });
        //}); 
   }
    
    function eliminar_subcategoria(id){
        
        Swal.fire({
        target: document.getElementById('modal_submaq') ,       
        title: 'CONFIRMACION',
        text: "DESEA ELIMINAR LA SUBCATEGORIA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, ELIMINAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_eliminar_subcategorias.jsp',
                data: ({id:id}),
                beforeSend: function() 
                {
                    Swal.fire({
                    target: document.getElementById('modal_submaq'),
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                
                aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,'modal_submaq',"3")  ;          
                var table = $('#table_subcat').DataTable();
                table.row('#'+id).remove().draw( false );
            }
                });
               
                
            }
    });  
   }
    
    function registrar_proveedor(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO PROVEEDOR?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_proveedor.jsp',
                data: $("#form_add_proveedor").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_proveedor(res.tipo_respuesta,res.mensaje,'modal_add_proveedor')  ;          
            }
                });
               
                
            }
    }); 
   }
    
    function registrar_operario(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO OPERARIO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_operario.jsp',
                data: $("#form_add_operario").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_operario_proveedor(res.tipo_respuesta,res.mensaje,'modal_add_operarios')  ;          
            }
                });
               
                
            }
    }); 
   }
    
    function actualizar_operario(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA REGISTRAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_actualizar_operario.jsp',
                data: $("#form_upd_operario").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_operario_proveedor(res.tipo_respuesta,res.mensaje,'modal_upd_operario')  ;          
            }
                });
               
                
            }
    }); 
   }
   
    function actualizar_proveedor(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA REGISTRAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_actualizar_proveedor.jsp',
                data: $("#form_upd_proveedor").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_proveedor(res.tipo_respuesta,res.mensaje,'modal_upd_proveedor')  ;          
            }
                });
               
                
            }
    }); 
   }
   
    function registrar_area(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO USUARIO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_area.jsp',
                data: $("#form_add_area").serialize()+"&tipo=1",
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
                success: function (res) 
                {
                    aviso_registro_area_rol(res.tipo_respuesta,res.mensaje,'modal_add_area','control_crear_area.jsp','form_add_area');            
                }
                    });
            }   
    }); 
   }
    
    function eliminar_vinculacion_subcategoria(id){
       
        Swal.fire({
        target: document.getElementById('modal_vinculacion') ,       
        title: 'CONFIRMACION',
        text: "DESEA ELIMINAR LA VINCULACION?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_eliminar_vinculacion_subcategorias.jsp',
                data: ({id:id }),
                beforeSend: function() 
                {
                    Swal.fire({
                    target: document.getElementById('modal_vinculacion') ,   
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_maquina_sub(res.tipo_respuesta,res.mensaje,'modal_vinculacion',"4")  ;           
                var table = $('#table_maquina_subcategoria').DataTable();
                table.row('#'+id).remove().draw( false );
            }
                });
               
                
            }
    }); 
   }
   
    function eliminar_area_rol(id,tipo,modal){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA INACTIVAR EL REGISTRO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_eliminar_areas_roles.jsp',
                data: ({id:id,tipo:tipo}),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_area_rol(res.tipo_respuesta,res.mensaje,modal);            
            }
                });
               
                
            }
    }); 
   }
    
    function registrar_rol(){
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO USUARIO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_crear_rol.jsp',
                data: $("#form_add_rol").serialize()+"&tipo=1",
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_registro_area_rol(res.tipo_respuesta,res.mensaje,'modal_add_rol','control_crear_rol.jsp','form_add_rol');            
            }
                });
               
                
            }
    }); 
   }
    
    function limpiar_modal_add_usuarios()
    {
        $('#nombre').val("");
        $('#apellido').val("");
        $('#usuario').val("");
        $('#pass').val("");
        $('#correo').val("");
        $('#select_areas').selectpicker('val', '');
    }

    function actualizar_nivel_usuario(id_usuario,id_nivel,tipo){
    
       $.ajax({
                type: "POST",
                url: cruds+'control_actualizar_usuario_nivel.jsp',
                data: ({id_usuario:id_usuario,id_nivel:id_nivel,tipo:tipo}),
                beforeSend: function() 
                {
                   /* Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoa*/
                },           
            success: function (res) 
            {
               // aviso_upd_user(res.tipo_respuesta,res.mensaje)            
            }
                });
}
    
    function actualizar_nivel_usuario(id_usuario,id_nivel,tipo,id_combo){
    
       $.ajax({
                type: "POST",
                url: cruds+'control_actualizar_usuario_nivel.jsp',
                data: ({id_usuario:id_usuario,id_nivel:id_nivel,tipo:tipo}),
                beforeSend: function() 
                {
                   /* Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoa*/
                },           
            success: function (res) 
            {
               $.get(ruta_consultas+'consulta_id_seleccionados_usuarios_correos.jsp',({id_usuario:id_usuario,id_nivel:id_nivel}), function(res)
                {
                    
                    //$('#'+id_combo).selectpicker('val', '');  
                   // $('#'+id_combo).selectpicker('refresh');
                    $('#'+id_combo).val(res.cbox_seleccionados.split(','));
                    $('#'+id_combo).selectpicker('refresh'); 
                                          
                } );   
            }
                });
}
    
    function actualizar_correos_destinatarios(id_usuario,arr_id_usuario_envio,id_nivel){
    
       $.ajax(  {
                    type: "POST",
                    url: cruds+'control_actualizar_correos_destinatario.jsp',
                    data: ({id_usuario:id_usuario,arr_id_usuario_envio:arr_id_usuario_envio,id_nivel:id_nivel}),
                    beforeSend: function() 
                    {

                    },           
                    success: function (res) 
                    {

                    }
                });
} 
    
    function actualizar_areas_usuario(id_usuario,id_area){
        
        $('#txt_areas_asignadas').val($('#area'+id_area).val()) ;
        
        
        $.ajax(  {
                    type: "POST",
                    url: cruds+'control_actualizar_usuario_areas.jsp',
                    data: ({id_usuario:id_usuario,areas: $('#txt_areas_asignadas').val()}),
                    beforeSend: function() 
                    {

                    },           
                    success: function (res) 
                    {

                    }
                });
        
    }
    
    function actualizar_opciones_roles(){
      $('#contenido_multiple_opciones').val($('#select_opciones').val());
        Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GUARDAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_actualizar_opciones_roles.jsp',
                data: ({id_rol:$('#cbox_rol').val(),opciones:$('#contenido_multiple_opciones').val()}),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
                success: function (res) 
                {
                    aviso_registro_area_rol(res.tipo_respuesta,res.mensaje,'modal_add_vinculacion_rol');            
                }
                });
           }
    }); 
         
}

    function actualizar_usuario(){
       Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GUARDAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds+'control_actualizar_usuario.jsp',
                data: $("#form_upd_user").serialize(),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
                success: function (res) 
                {
                    aviso_registro_area_rol(res.tipo_respuesta,res.mensaje,'modal_upd_user');  
                    ir_grilla_usuarios('7');
                }
                });
           }
    }); 
         
}

    function restablecer_pass_usuario(id_usuario){
       $.ajax({
                type: "POST",
                url: cruds+'control_restablecer_pass.jsp',
                data: ({id_usuario:id_usuario}),
                beforeSend: function() 
                {
                    Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                        }, 1000);
                    } 
                    });
                },           
            success: function (res) 
            {
                aviso_upd_user(res.tipo_respuesta,res.mensaje)            
            }
                });
}

    function aviso_registro_user(tipo,mensaje){
       if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });
                 ir_grilla_usuarios('7');
                 $('#modal_add_usuarios').modal('toggle'); 
       }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
        
   }
  
    function aviso_registro_operario_proveedor(tipo,mensaje,modal){
       if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });
                 ir_grilla_operarios();
                  $('#'+modal).modal('toggle'); 
       }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
        
   }

    function aviso_registro_proveedor(tipo,mensaje,modal){
       if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });
                 ir_grilla_proveedores();
                  $('#'+modal).modal('toggle'); 
       }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
        
   }
    
    function aviso_registro_area_rol(tipo,mensaje,id_modal,control,form){
        if(tipo=="1")
       {
            swal.fire({
            type: 'success',
            text:mensaje,
            confirmButtonText: "CERRAR"
                });
            $('#'+id_modal).modal('toggle'); 
       }
        else if(tipo=="2")
        {
            Swal.fire({
            title: 'DATOS EXISTENTES',
            text: mensaje,
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO, CANCELAR!' }).then((result) => 
            {
                if (result.value) 
                {
                    $.ajax({
                    type: "POST",
                    url: cruds+control,
                    data: $("#"+form).serialize()+ "&tipo=2", 
                    beforeSend: function() 
                    {
                        Swal.fire({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                            }, 1000);
                        } 
                        });
                    },           
                    success: function (res) 
                    {
                        aviso_registro_area_rol(res.tipo_respuesta,res.mensaje,id_modal);            
                    }
                    });
               }
        }); 
       }
        else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
        
   }    
   
    function aviso_upd_user(tipo,mensaje){
       if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });
       }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
        
   }  
    
    function aviso_registro_ot(tipo,mensaje){
       if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });     
               traer_menu();
       }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
    }
    
    function seleccionar_opciones(){
        $.get(ruta_consultas+'consulta_vinculacion.jsp',{cbox_rol:$("#cbox_rol").val()},function(res)
        {
            $('#select_opciones').selectpicker('val', '');
            $('#select_opciones').selectpicker('refresh');
            $('#select_opciones').val(res.selected.split(','));
            $('#select_opciones').selectpicker('refresh');
        });        
    }
    
    function actualizar_estado_operario(id,estado){
        $.get(cruds+'control_actualizar_operario_estado.jsp',{id:id,estado:estado},function(res)
        {
            
        });
    }
    
    function actualizar_estado_proveedor(id,estado){
        $.get(cruds+'control_actualizar_proveedor_estado.jsp',{id:id,estado:estado},function(res)
        {
            
        });
    }

    function aprobar_registro(id_pedido) {

        Swal.fire({
            title: 'APROBACION DE PEDIDO DE TRABAJO',
            text: "DESEA APROBAR EL PEDIDO?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            html: "<input type='text' class='form-control' id='nota' placeholder='AGREGAR NOTA'>",
            confirmButtonText: 'APROBAR!',
            cancelButtonText: 'CANCELAR!'
        }).then((result) => {
            if (result.value) {

                $.ajax({
        type: "POST",
        url: cruds + "control_aprobar_ja.jsp",
        data: ({ id_pedido: id_pedido, notas: $('#nota').val()}),
        beforeSend: function () {
            Swal.fire({
                title: 'PROCESANDO!',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                            .textContent = Swal.getTimerLeft()
                    }, 1000)
                }
            });
        },
        success: function (data) {
            aviso_aprobaciones(data.tipo_respuesta, data.mensaje, "grilla_pendientes_ja.jsp");
        } 
            });

            }
        });
    }
    
    function form_aprobar_jm( id,detalle,descripcion) {

    var html;
    html = "   <form id='form_cuadro_operarios'>   <div id='combo' class='form - group'> <a>TERCERIZADOS</a>\n\
                            <input  type='checkbox' data-toggle='toggle'  data - on='SI' data - off='NO' id = 'check_terc' data - onstyle='success' data - offstyle='warning' >\n\
                            <select style = ' display:none; width: 400px; height: 80px' name = 'proveedor'   id = 'proveedor' class='form - control'  multiple = 'multiple' >\n\
                            </select ><br><br>\n\
                            </div ><input type='hidden' id='txt_terc' name='txt_terc' value='NO'> \n\
                            <a> ENCARGADO DE MANTENIMIENTO</a >\n\
                            <select style = 'font-weight: bold;' class='form-control' name = 'cbox_encargado_mant' id = 'cbox_encargado_mant' >\n\
                            </select ><br><br><textarea style='text - transform: uppercase; width: 400px; height: 80px'  name = 'nota' id='nota' class='form - control' placeholder='AGREGAR NOTA'></textarea>\n\
                            <br><br><br><input type='submit' value='REGISTRAR' class='form-control bg-success btn color_letra' >  </form> ";
    Swal.fire({
        title: 'ASIGNACION DE OPERARIOS',
        text: "DESEA REGISTRAR LA RESOLUCION?",
        type: 'warning',
        html: html,

        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
    });
   
 
        $.get(ruta_consultas + 'consulta_encargados_mant.jsp',   function (res) {
            $("#cbox_encargado_mant").html(res.cbox_operarios);
            $('#check_terc').bootstrapToggle();

            $.get(ruta_consultas + 'consulta_tercerizados.jsp', function (res) {
                $("#proveedor").html(res.cbox_tercerizados);

                $('#form_cuadro_operarios').on('submit', function (e) { 
                    e.preventDefault(); 
                    aprobar_registro_jm(  id, descripcion, detalle, $("#nota").val(),$('#proveedor option:selected').toArray().map(item => item.value).join(),$("#cbox_encargado_mant :selected").val(), $("#txt_terc").val());
                    e.stopPropagation();
                });

                $(function () {
                    $('#check_terc').change(function () {
                        if ($(this).prop("checked") == true) {
                            $('#proveedor').show();
                            $("#proveedor").prop('required', true);
                            $("#proveedor option:selected").prop("selected", false);
                            $("#txt_terc").val("SI");
                        }
                        else {
                            $('#proveedor').hide();
                            $("#proveedor").prop('required', false);
                            $("#proveedor option:selected").prop("selected", false);
                            $("#txt_terc").val("NO");
                        }
                    });
                });
                 
            }); 
        });
    }
    
    function aprobar_registro_jm(id,descripcion, detalle, nota,cbox_terc,cbox_encargado,condicion_terc) 
    {
        Swal.fire({
        title: 'APROBACION PEDIDO',
        text: "DESEA APROBAR EL PEDIDO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, APROBAR!',
        cancelButtonText: 'NO, CANCELAR!'
        }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds + "control_aprobar_jm.jsp",
                data: ({ id: id, cbox_terc: cbox_terc, cbox_encargado: cbox_encargado, nota: nota,descripcion:descripcion,detalle:detalle,condicion_terc:condicion_terc}),
                beforeSend: function () 
                {
                    Swal.fire
                    ({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                              }, 1000);
                          }
                    });
                },
                success: function (data) 
                {
                    aviso_aprobaciones(data.tipo_respuesta,data.mensaje,"grilla_pendientes_jm.jsp");
                } 
              });
            } 
        });
    }
    
    function aprobar_registro_em(id,cbox_operario,  nota) 
    {
        Swal.fire({
        title: 'APROBACION DE ASIGNACION DE OPERARIOS',
        text: "DESEA APROBAR EL PEDIDO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, APROBAR!',
        cancelButtonText: 'NO, CANCELAR!'
        }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds + "control_aprobar_em.jsp",
                data: ({ id: id, cbox_operario: cbox_operario, nota: nota}),
                beforeSend: function () 
                {
                    Swal.fire
                    ({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                              }, 1000);
                          }
                    });
                },
                success: function (data) 
                {
                    aviso_aprobaciones(data.tipo_respuesta,data.mensaje,"grilla_pendientes_em.jsp");
                } 
              });
            } 
        });
    }
    
    function aprobar_registro_resolucion(id,resolucion,  nota,fecha_ejecucion) 
    {
        Swal.fire({
        title: 'CARGA DE RESOLUCION',
        text: "DESEA REGISTRAR LA RESOLUCION INGRESADA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!'
        }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds + "control_aprobar_resolucion.jsp",
                data: ({ id: id, txt_resolucion: resolucion, nota: nota,fecha_ejecucion:fecha_ejecucion}),
                beforeSend: function () 
                {
                    Swal.fire
                    ({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                              }, 1000);
                          }
                    });
                },
                success: function (data) 
                {
                    aviso_aprobaciones(data.tipo_respuesta,data.mensaje,"grilla_pendientes_resolucion.jsp");
                } 
              });
            } 
        });
    }
    
    function aprobar_registro_verificacion(id, nota) 
    {
        Swal.fire({
         text: "DESEA APROBAR LA VERIFICACION?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!'
        }).then((result) => 
        {
            if (result.value) 
            {
                $.ajax({
                type: "POST",
                url: cruds + "control_aprobar_verificacion.jsp",
                data: ({ id: id,   nota: nota}),
                beforeSend: function () 
                {
                    Swal.fire
                    ({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                              }, 1000);
                          }
                    });
                },
                success: function (data) 
                {
                    aviso_aprobaciones(data.tipo_respuesta,data.mensaje,"grilla_pendientes_verificacion.jsp");
                } 
              });
            } 
        });
    }
    function form_aprobar_em( id) 
    {
        var html;
        html = "   <form id='form_cuadro_operarios'>   \n\
                        <div id='combo' class='form - group'> <a></a>\n\
                            <select style = '   width: 400px; height: 80px' name = 'cbox_operario' id='cbox_operario' class='form - control'  multiple = 'multiple'  required>\n\
                            </select ><br><br>\n\
                        </div > \n\
                        <br><textarea style='text - transform: uppercase; width: 400px; height: 80px'  name = 'nota' id='nota' class='form - control' placeholder='AGREGAR NOTA'></textarea>\n\
                        <br><br><br><input type='submit' value='REGISTRAR' class='form-control bg-success btn color_letra' >  \n\
                    </form> ";
        Swal.fire({
        title: 'ASIGNACION DE OPERARIOS',
        text: "DESEA REGISTRAR LOS DATOS INGRESADOS?",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
        });

        $.get(ruta_consultas + 'consulta_operarios.jsp',function (res) 
        {
            $("#cbox_operario").html(res.cbox_operarios);
            $('#form_cuadro_operarios').on('submit', function (e) 
            { 
                e.preventDefault(); 
                aprobar_registro_em(  id,$('#cbox_operario option:selected').toArray().map(item => item.value).join(), $("#nota").val());
                e.stopPropagation();
            });
        });
    }
   
    function form_registrar_resolucion( id) 
    {
        
    
    
        var html;
        html = "   <form id='form_cuadro_resolucion'>   \n\
                        <br> <a>FECHA DE EJECUCION</a> \n\
                        <input type='text'placeholder='INGRESE FECHA DE EJECUCION' style='width: 400px; height: 30px' ' id='fecha_ejecucion' name='fecha_ejecucion' class='datepicker'><br>   \n\
                        <br><br><div  class='form - group'> <a></a>\n\
                            <textarea style='text - transform: uppercase; width: 400px; height: 80px'  required name = 'txt_resolucion' id='txt_resolucion' class='form - control' placeholder='AGREGAR RESOLUCION'></textarea><br><br>\n\
                        </div > \n\
                        \n\
                        <br><textarea style='text - transform: uppercase; width: 400px; height: 80px'  name = 'nota' id='nota' class='form - control' placeholder='AGREGAR NOTA'></textarea>\n\
                        <br><br><br><input type='submit' value='REGISTRAR' class='form-control bg-success btn color_letra' >  \n\
                    </form> ";
        Swal.fire({
        title:"CARGA DE RESOLUCION",
        text: "DESEA REGISTRAR LA RESOLUCION?",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
        });
 
             
            $('#form_cuadro_resolucion').on('submit', function (e) 
            { 
                e.preventDefault(); 
                aprobar_registro_resolucion(id,$("#txt_resolucion").val(), $("#nota").val(), $("#fecha_ejecucion").val());
                e.stopPropagation();
            });
             cargar_estilo_calendario();
            $.get(ruta_consultas+'consulta_fecha.jsp',function(res)
                {
                  $('#fecha_ejecucion').val(res.fecha);
                  
                 }); 
    
    }

    function form_registrar_verificacion( id) 
    {
        var html;
        html = "   <form id='form_cuadro_verificacion'>   \n\
                        <br><textarea style='text - transform: uppercase; width: 400px; height: 80px'  name = 'nota' id='nota' class='form - control' placeholder='AGREGAR NOTA(OPCIONAL)'></textarea>\n\
                        <br><br><br><input type='submit' value='REGISTRAR' class='form-control bg-success btn color_letra' >  \n\
                    </form> ";
        Swal.fire({
        title:"APROBACION DE VERIFICACION",
        text: "DESEA REGISTRAR APROBAR LA VERIFICACION?",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
        });
            $('#form_cuadro_verificacion').on('submit', function (e) 
            { 
                e.preventDefault(); 
                aprobar_registro_verificacion(id,  $("#nota").val());
                e.stopPropagation();
            });
        
    }

    function form_registrar_tipo_problema() 
    {
        var html;
        html = "   <form id='form_cuadro'>   \n\
                        <br><input type='text' id='descripcion' name='descripcion' placeholder='INGRESE NUEVO TIPO DE PROBLEMA' required> \n\
                        <br><br><br><input type='submit' value='REGISTRAR' class='form-control bg-success btn color_letra' >  \n\
                    </form> ";
        Swal.fire({
        title:"CREACION DE NUEVO TIPO DE PROBLEMA",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
        });
            $('#form_cuadro').on('submit', function (e) 
            { 
                e.preventDefault(); 
                    $.ajax({
                    type: "POST",
                    url: cruds + "control_crear_tipo_problema.jsp",
                    data: $("#form_cuadro").serialize(),
                    beforeSend: function () 
                    {
                        Swal.fire
                        ({
                            title: 'PROCESANDO!',
                            html: 'ESPERE<strong></strong>...',
                            allowOutsideClick: false,
                            onBeforeOpen: () => {
                            Swal.showLoading()
                            timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                                  }, 1000);
                              }
                        });
                    },
                    success: function (data) 
                    {
                        aviso_registro_tipo_problema(data.tipo_respuesta,data.mensaje,"1");
                    } 
                  });
                e.stopPropagation();
            });
        
    }
    
    function aviso_registro_tipo_problema(tipo,mensaje,condicion){
        if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });     
            if(condicion=="1"){
                listar_grilla_tipo_problema();
            }
            if(condicion=="2"){
                listar_grilla_tipo_problema();
            }
        }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
    }
    
    function aviso_aprobaciones(tipo,mensaje,pagina){
        if(tipo=="1"){
        swal.fire({
                type: 'success',
                text:mensaje,
                confirmButtonText: "CERRAR"
                });     
            ir_grilla_pendiente_aprobaciones(pagina)   
        }
       else {
           swal.fire({
                type: 'error',
                html:mensaje,
                confirmButtonText: "CERRAR"
                });  
       }
    }
    
    function actualizar_pass(){
        var html;
        html = "   <form id='form_cuadro_pass'>   \n\
                        <br><input type='text' id='txt_pass' name='txt_pass' class='form-control' placeholder='INGRESE NUEVA CONTRASE??A' required>\n\
                        <br><br><br><input type='submit' value='REGISTRAR' class='form-control bg-success btn color_letra'>  \n\
                    </form> ";
        Swal.fire({
         title: "ACTUALIZACION DE CONTRASE&NtildeA",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
        });
            $('#form_cuadro_pass').on('submit', function (e) 
            { 
                e.preventDefault(); 
                    $.ajax({
                    type: "POST",
                    url: cruds+'control_actualizar_pass.jsp',
                    data: ({txt_pass:$('#txt_pass').val()}),
                    beforeSend: function() 
                    {
                        Swal.fire({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                            }, 1000);
                        } 
                        });
                    },           
                    success: function (res) 
                    {
                        aviso_upd_user(res.tipo_respuesta,res.mensaje)            
                    }
                    });               
                e.stopPropagation();
            });
   }
   
    function cancelar_ot(id,tipo_cancelacion,pagina) 
    {
            var html;
            html = "   <form id='form_cuadro_cancelacion'>   \n\
                             <br><textarea style='text - transform: uppercase; width: 400px; height: 80px'  required name = 'txt_motivo' id='txt_motivo' class='form - control' placeholder='INGRESE EL MOTIVO'></textarea>\n\
                            <br><br><br><input type='submit' value='RECHAZAR RESOLUCION' class='form-control bg-success btn color_letra' >  \n\
                        </form> ";
            Swal.fire({
            title: "DESEA RECHAZAR LA RESOLUCION?",
            type: 'warning',
            html: html,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            showCancelButton: false,
            showConfirmButton: false
            });
            $('#form_cuadro_cancelacion').on('submit', function (e) 
                { 
                    e.preventDefault(); 
                        $.ajax({
                        type: "POST",
                        url: cruds + "control_cerrar_ot.jsp",
                        data: ({ id: id, tipo_cancelacion, txt_motivo: $('#txt_motivo').val()}),
                        beforeSend: function () 
                        {
                            Swal.fire
                            ({
                                title: 'PROCESANDO!',
                                html: 'ESPERE<strong></strong>...',
                                allowOutsideClick: false,
                                onBeforeOpen: () => {
                                Swal.showLoading()
                                timerInterval = setInterval(() => {
                                Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                                      }, 1000);
                                  }
                            });
                        },
                        success: function (data) 
                        {
                            aviso_aprobaciones(data.tipo_respuesta,data.mensaje,pagina);
                        } 
                      });                
                  e.stopPropagation();
                });

    }   
    
    function cargar_estilo_calendario(){
    
       $('.datepicker').pickadate({
        // Escape any ???rule??? characters with an exclamation mark (!).
        format: 'dd/mm/yyyy',
        formatSubmit: 'dd/mm/yyyy',
        hiddenPrefix: 'prefix__',
        hiddenSuffix: '__suffix',
        cancel: 'Cancelar',
        clear: 'Limpiar',
        done: 'Ok',
        today: 'Hoy',
        close: 'Cerrar',
        max: true,
       // required:true,
        // editable: true,
        monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthsShort: ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'],
        weekdaysFull: ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'],
        weekdaysShort: ['dom', 'lun', 'mar', 'mie', 'jue', 'vie', 'sab']
      });
            
}

    function activar_datatable_pendientes()
    {
        $("#table_pendientes").DataTable(
        { 
            //scrollY:    "500px",
            scrollX:    true,
            order: [[11, 'desc']],
            rowGroup: 
            {
                startRender: function ( rows, group ) {

                   return $('<tr/>')
                        .addClass('colorCheck')
                        .append( '<td>' + group + '</td>' )
                        .append( '<td>(TOTAL:' +  rows.count() + ')</td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                        .append( '<td></td>' )
                },
                dataSrc: 11
            },
            dom: 'Bfrtip',
            "pageLength": 100,
            "language": 
            {
                "sSearch":         "Buscar:",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ning??n dato disponible en esta tabla",
                "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
            "oPaginate": {
                            "sFirst":    "Primero",
                            "sLast":     "??ltimo",
                            "sNext":     "Siguiente",
                            "sPrevious": "Anterior"
                        }, 
             //  "sUrl": "js/Spanish.txt" ,
               buttons: {
                copyTitle: 'DATOS COPIADOS',
                copySuccess: {
                    _: '%d FILAS COPIADAS' 
                }
            }  
            },
            buttons: [
            {
                extend: 'copyHtml5',
                text: 'COPIAR GRILLA',
                exportOptions: {
                columns: [ 0, ':visible' ]
                    }
            },
            {
                extend: 'excelHtml5',
                title:'INFORME PEDIDOS',                
                text: 'EXCEL',
                     
            
                exportOptions: {
                    columns: ':visible'
                }
            },
            {
                extend: 'pdfHtml5',
                text: 'PDF',
                title: 'INFORME PEDIDOS',
                orientation: 'landscape',
                pageSize: 'LEGAL',
                customize: function(doc) {
                  
                    doc.styles.title = {
                      color: 'white',
                      fontSize: '20',
                      background: 'black',
                      alignment: 'center'
                      
                    }
                    doc.styles.tableHeader = {
                       fontSize: '6'
                    }
                    doc.styles.tableBodyEven = {
                      fontSize: '6'
                    }
                    doc.styles.tableBodyOdd = {
                       fontSize: '6'
                    }
                   doc.styles.tableFooter = {
                       fontSize: '6'
                    }
                   doc.styles['td:nth-child(2)'] = { 
                      width: '100px',
                      'max-width': '100px'
                    }
                  }   ,
                exportOptions: {
                    columns: ':visible'
                 }
            },
            'colvis'
        ], keys: {
        clipboard: false
        }});
     }
     
    function seleccionar_usuarios_correos(id_usuario,id_nivel,id_combo)
    {
       actualizar_nivel_usuario(id_usuario,id_nivel,'1',id_combo); 
        
    }