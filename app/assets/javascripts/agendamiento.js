$('#modal-container').on('show.bs.modal', function (e) {
	$('select.select_paciente').select2({ width: '350px', placeholder: 'Selecciona un paciente', allowClear: true });
	$('select.select_quien_pide').select2({ width: '350px', placeholder: 'Selecciona una persona', allowClear: true });
	$('select.select_capitulo').select2({ width: '350px', placeholder: 'Selecciona un motivo', allowClear: true });
	$('select.select_antecedente').select2({ width: '350px', placeholder: 'Selecciona un antecedente', allowClear: true});
	$('select.select_persona_hora').select2({ width: '350px', placeholder: 'Selecciona una persona', allowClear: true});
	
	$(".select_persona_hora").on("change", function(e) { 
		var h = $(this).attr('id').substring(11); 
		var mc = $(this).select2('data').id;
		m_c = $('#m_c_'+h).find('input[name=radios-motivo-'+h+']:checked').val();
		if (mc == "Para mi"){				
			if (m_c=='2'){
				$('#div-sel-ant-'+h).show();
				$('#div-sel-cap-'+h).hide();	
			}
			$('#m_c_'+h).show();	
		} else {
			$('#div-sel-ant-'+h).hide();
			$('#m_c_'+h).hide();
			$('#div-sel-cap-'+h).show();				
		}	 
	})

	$(".select_paciente").on("change", function(e) { 
		var id = $(this).attr('id').substring(11);
		var valor = $(this).select2('data');
		$('#select_ped_'+id).select2("val", "");
		$('#select_ped_'+id).find('option').remove();
		$('#select_ped_'+id).append('<option></option>');

		if (valor){
			$('#select_ped_'+id).prop("disabled", false);
			$('#link_ped_'+id).show();
			$.ajax({
				type: 'POST',
				url: '/cargar_cercanos',
				data: {	persona_id: $(this).select2('data').id },
				success: function(response) {
					$('#select_ped_'+id).append('<option>El mismo paciente</option>');
					for (var prop in response) 
						$('#select_ped_'+id).append('<option value='+prop+'>'+response[prop]+'</option>');
				},
				error: function(xhr, status, error){ alert("No se pudieron cargar las personas relacionadas al paciente."); }
			}); 
		}
		else{
			$('#select_ped_'+id).prop("disabled", true);
			$('#link_ped_'+id).hide();
		}
	})
})