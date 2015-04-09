(function($){
	var treeReady = true;
	var creationMode = false;
	
	// formulaire de rechercher du collab, avant de submiter le formulaire, prise en compte du filtre
	$('#recherche_collab .submit').click(function(){
		var filtre = $('#recherche_collab #type_objet').val();
		$("#recherche_collab .recherche_objet").val(filtre);
	});
	
	// gestion sous menu espace collab
	$('.menu_collaboratif .gestion_item > a').click(function(){
		var $this = $(this);
		$this.parent().find('> ul').toggle();
		// pour ne pas interpreter le href, return false
		return false;
	});

	
	// Gestion de l'arborescence
	var $kTree = $('.kTree'),
		cancel = {position: -1};
	
	function _isInDatas(a, word){
		var inDatas = false;
		if(a){
			var $item = $(a).closest('li');
			$.each($item.data(), function(index, value){
				if(value.toLowerCase().indexOf(word) > -1){
					inDatas = true;
					return false;
				}
			});
		}
		return inDatas;
	}
	
	$kTree.each(function(index, component){
		var $component = $(component),
			filterUrl = $component.data('filterurl'),
			dataUrl = $component.data('url'),
			dnd = $component.data('dnd') ? $component.data('dnd') : false,
			actions = $component.data('actions') ? $component.data('actions') : false;
			codeEspaceCourant = $('#codeEspaceCourant').val();
		
		// Only enable checkboxes in multiselect cases
		var plugins = ["themes", "ui", "json_data", "hotkeys", "types"];
		if(dnd){
			plugins.push("dnd");
			plugins.push("crrm");
		}
		if(actions){
			plugins.push("actions");
		}
		
		// Only way to not trigger the 'select_node.jstree' event on load with the param 'initially_select' for 'ui' plugin
		$component.bind("reselect.jstree", function() { treeReady = true; }).jstree({
			core : {
				animation: 300,
				html_titles : true
			},
			"json_data" : {
				"ajax" : {
					"url" : function( node ){
	                      if( node == -1 ){	                    	  
	                        return $.parametizeString(dataUrl, ["00"]);
	                      } else {
	                        return $.parametizeString(dataUrl, [node.data('sCode')]);
	                      }
	                    },
		            "type" : "get",  // this is a GET not a POST
		            "success" : function(ops) {
		            	if(ops[0]){
		            		if(ops[0].attr.rel == "root"){
		            			return ops;
		            		}
		            		return ops[0].children;
		            	}
		            },
		            "progressive_render" : true,
		            "progressive_unload" : true
				}	
			},
			"themes" : {
				"theme" : "ksup",
				"url" : "/adminsite/scripts/libs/css/jstree-1.0/themes/ksup/style.css",
				"dots" : true,
				"icons" : true
			},
			"ui" : {
				"select_limit" : 1
			},
			"types" : {
				"valid_children" : [ "root" ],
				"types" : {
					"root" : {
						"valid_children" : [ "default" ]
					},
					"default" : {
						"valid_children" : [ "default" ]
					},
					"not_selectable" : { 
		              "check_node" : false, 
		              "uncheck_node" : false,
		              "hover_node" : false,
		              "select_node" : function () {return false;}
		            } 
				}
			},
			"crrm" : { 
				"move" : {
					"check_move" : function (m) {					
						return true;
					}
				}
			},
			"dnd" : {
				"drop_target" : false,
				"drag_target" : false
			},
			"actions" : {
				filter: function(){
					return true;
				},
				buttons: [{
					label: 'Ajouter',
					className : 'ajouter',
					binding: {
						'click' : function(event){
							var $node = $(this).closest('li');
							$kTree.jstree('create', $node, 'last', {data : 'Nouveau dossier'}, null, false);
						}
					}
				},
				{
					label: '&Eacute;diter',
					className : 'editer',
					binding: {
						'click' : function(event){
							var $node = $(this).closest('li');
							$node.data('libelleAvantRenommage', $node.data('libelle'));
							$kTree.jstree("rename", $node);
						}
					}
				},
				{
					label: "Supprimer",
					className : 'supprimer',
					binding: {
						'click' : function(event){
							console.log('supprimer');
							var $node = $(this).closest('li');
							tree = $.jstree._reference('.kTree');
							deleteFolder(event, $node, tree);
						}
					}
				}]
			},
			"plugins" : plugins
		});
	});
	
	$kTree.bind("select_node.jstree", function (event, data) { 
//		if(treeReady && window.iFrameRegistration){
//			var path = $.jstree._reference('.kTree').get_path('#' + data.rslt.obj.data('sCode'));
//			path = $.cleanArray(path).join(' > ');
//			iFrameHelper.sendValues(window.iFrameRegistration, {sCode: data.rslt.obj.data('sCode'), libelle: data.rslt.obj.data('libelle'), fil: path});
//		}
		// la consultation d'un dossier n'est disponible qu'en vue arborescence
		if (typeof(estVueArborescence) != "undefined" && estVueArborescence()){
			var $node = data.rslt.obj,
			$messageApplicatif = $('#messageApplicatif'),
			$contenuDossier = $('.contenuDossier'),
			$p = $('<p>').addClass('message alert fade in'),
			$closeButton = $('<button>').addClass('close').attr({ 'type' : 'button', 'data-dismiss' : 'alert', 'aria-hidden' : true}).html('&times;');
			$.ajax({
				type: "POST",
				url: '/servlet/com.kportal.servlet.JsTreeServlet',
				dataType:'json',
				data: { 'JSTREEBEAN': 'dossierGwJsTree', 'ACTION': 'AFFICHER_FICHES', 'CODES_DOSSIERGW': [$node.data('sCode')], 'CODE_ESPACE_COURANT' : codeEspaceCourant},
				success: function(data, status){
					var htmlContenu = '';
					htmlContenu = '<ul>';
					$.each(data,function(i,item){
						htmlContenu = htmlContenu + '<li>';
						htmlContenu = htmlContenu + '<a href="';
						htmlContenu = htmlContenu + item.url;
						htmlContenu = htmlContenu + '" class="';
						htmlContenu = htmlContenu + item.classe;
						htmlContenu = htmlContenu + '">';
						htmlContenu = htmlContenu + item.libelle;
						htmlContenu = htmlContenu + '</a>';
						htmlContenu = htmlContenu + '</li>';
				    });
					htmlContenu = htmlContenu + '</ul>';
					$contenuDossier.html(htmlContenu);
					// affiche le contenu du dossier
					$('#contenuDossier').show();
				},
				error: function(jqXHR, status, error){
						var message = jqXHR.responseText ? jqXHR.responseText : LOCALE_BO.services.arbre.indisponible;
						$p.addClass('alert-danger');
						$p.html(message);
						$p.appendTo($messageApplicatif);	
						$closeButton.appendTo($p);
						$p.alert();
						// cache le contenu du dossier
						$('#contenuDossier').hide();
				}
			});
		}
	});
	
	$(document).bind("drag_start.vakata", function (e, data) { 
		var $node = data.data.obj;
		cancel = {
			node : $node,
			parent : $.jstree._reference('.kTree')._get_parent($node),
			position : $node.index()
		};
	}); 
	
	function cancelMove(){
		if(cancel && cancel.node && cancel.parent && cancel.position != -1){
			$.jstree._reference('.kTree').move_node(cancel.node, cancel.parent, cancel.position);
			cancel = {position: -1};
		}
	}
	
	
	$kTree.bind("move_node.jstree", function (event, data) {
		var $node = data.rslt.o,
		    codeMere = data.rslt.np.data('sCode'),
			$messageApplicatif = $('#messageApplicatif'),
			$p = $('<p>').addClass('message alert fade in'),
			$closeButton = $('<button>').addClass('close').attr({ 'type' : 'button', 'data-dismiss' : 'alert', 'aria-hidden' : true}).html('&times;');
			$.ajax({
				type: "POST",
				url: '/servlet/com.kportal.servlet.JsTreeServlet',
				data: { 'JSTREEBEAN': 'dossierGwJsTree', 'ACTION': 'DEPLACER', 'CODES_DOSSIERGW': [$node.data('sCode')], 'CODES_MERE': [codeMere], 'ORDRES' : [$node.index()], 'CODE_ESPACE_COURANT' : codeEspaceCourant},
				success: function(data, status){
						  $p.addClass('alert-success');
						  $p.html(data);
						  $p.appendTo($messageApplicatif);	
						  $closeButton.appendTo($p);
						  $p.alert();
						  $node.transition({ 'background-color' : '#eda619', duration: 500}, function(){
							  $node.transition({ 'background-color' : '#fff', delay: 500});
						  });
				},
				error: function(jqXHR, status, error){
						var message = jqXHR.responseText ? jqXHR.responseText : LOCALE_BO.services.arbre.indisponible;
						$p.addClass('alert-danger');
						$p.html(message);
						$p.appendTo($messageApplicatif);	
						$closeButton.appendTo($p);
						$p.alert();
						cancelMove();
				}
			});
	});
	
	
	$kTree.bind("rename_node.jstree", function(event, data){
		if(creationMode){
			handleCreateNode(event, data);
		}else{
			handleRenameNode(event, data);
		}
	});

	function handleRenameNode(event, data){
		var $node = data.args[0],
		nouveauNom = data.rslt.name,
		$messageApplicatif = $('#messageApplicatif'),
		$p = $('<p>').addClass('message alert fade in'),
		$closeButton = $('<button>').addClass('close').attr({ 'type' : 'button', 'data-dismiss' : 'alert', 'aria-hidden' : true}).html('&times;');
		// test de l'element root, impossible de le renommer
		if ($node.attr('rel') == 'root') {
			var message = 'Impossible de renommer le dossier racine';
			$p.addClass('alert-danger');
			$p.html(message);
			$p.appendTo($messageApplicatif);	
			$closeButton.appendTo($p);
			$p.alert();
			// retablissement de l'ancien nom
			$node.data('libelle', $node.data('libelleAvantRenommage'));
			$node.attr('title',$node.data('libelleAvantRenommage'));
			$node.find('>a:first').html($node.data('libelleAvantRenommage'))
		} else {
			$.ajax({
				type: "POST",
				url: '/servlet/com.kportal.servlet.JsTreeServlet',
				data: { 'JSTREEBEAN': 'dossierGwJsTree', 'ACTION': 'EDITER', 'CODES_DOSSIERGW': [$node.data('sCode')], 'NOUVEAU_NOM_DOSSIER': [nouveauNom], 'CODE_ESPACE_COURANT' : codeEspaceCourant},
				success: function(data, status){
						  $p.addClass('alert-success');
						  $p.html(data);
						  $p.appendTo($messageApplicatif);	
						  $closeButton.appendTo($p);
						  $p.alert();
						  $node.transition({ 'background-color' : '#eda619', duration: 500}, function(){
							  $node.transition({ 'background-color' : '#fff', delay: 500});
						  });
				},
				error: function(jqXHR, status, error){
						var message = jqXHR.responseText ? jqXHR.responseText : LOCALE_BO.services.arbre.indisponible;
						$p.addClass('alert-danger');
						$p.html(message);
						$p.appendTo($messageApplicatif);	
						$closeButton.appendTo($p);
						$p.alert();
						// retablissement de l'ancien nom
						$node.data('libelle', $node.data('libelleAvantRenommage'));
						$node.html($node.data('libelleAvantRenommage'));
				}
			});
		}
	}
	
	$kTree.bind("create_node.jstree", function(event, data){
		creationMode = true;
	});
	
	function handleCreateNode(event, data){
		var $node = data.args[0],
		nouveauNom = data.rslt.name,
		$messageApplicatif = $('#messageApplicatif'),
		$p = $('<p>').addClass('message alert fade in'),
		$closeButton = $('<button>').addClass('close').attr({ 'type' : 'button', 'data-dismiss' : 'alert', 'aria-hidden' : true}).html('&times;');
		$.ajax({
			type: "POST",
			url: '/servlet/com.kportal.servlet.JsTreeServlet',
			data: { 'JSTREEBEAN': 'dossierGwJsTree', 'ACTION': 'AJOUTER', 'CODES_PARENT': [$node.parent().closest('li').data('sCode')], 'NOMS_DOSSIERGW': [nouveauNom], 'CODE_ESPACE_COURANT' : codeEspaceCourant},
			success: function(data, status){
					  $p.addClass('alert-success');
					  $p.html('Le dossier ' + nouveauNom + ' a été ajouté avec succés.');
					  $node.data('sCode',data);
					  $p.appendTo($messageApplicatif);	
					  $closeButton.appendTo($p);
					  $p.alert();
					  $node.transition({ 'background-color' : '#eda619', duration: 500}, function(){
						  $node.transition({ 'background-color' : '#fff', delay: 500});
					  });
					  creationMode = false;
			},
			error: function(jqXHR, status, error){
					var message = jqXHR.responseText ? jqXHR.responseText : LOCALE_BO.services.arbre.indisponible;
					$p.addClass('alert-danger');
					$p.html(message);
					$p.appendTo($messageApplicatif);	
					$closeButton.appendTo($p);
					$p.alert();
					creationMode = false;
			}
		});
	}
	
	// Suppression de l'élément
	function deleteFolder(event, node, tree){
		var $ = jQuery,
			$messageApplicatif = $('#messageApplicatif'),
			$p = $('<p>').addClass('message alert fade in'),
			$closeButton = $('<button>').addClass('close').attr({ 'type' : 'button', 'data-dismiss' : 'alert', 'aria-hidden' : true}).html('&times;');
		$.ajax({
		  type: "POST",
		  url: '/servlet/com.kportal.servlet.JsTreeServlet',
		  data: { 'JSTREEBEAN': 'dossierGwJsTree', 'ACTION': 'SUPPRIMER', 'CODES_DOSSIERGW': [node.data('sCode')], 'CODE_ESPACE_COURANT' : codeEspaceCourant },
		  success: function(data, status){
			  $p.addClass('alert-success');
			  $p.html(data);
			  $p.appendTo($messageApplicatif);	
			  $closeButton.appendTo($p);
			  $p.alert();
			  node.transition({opacity: 0}, function(){
				  tree.delete_node(node);
			  });
		  },
		  error: function(jqXHR, status, error){
			  $p.addClass('alert-danger');
			  $p.html(jqXHR.responseText);
			  $p.appendTo($messageApplicatif);	
			  $closeButton.appendTo($p);
			  $p.alert();
		  }
		});
	}
	
})(jQuery.noConflict());