$('#modal-container').on('show.bs.modal', function (e) {
	$('select.select_paciente').select2({ width: '350px', placeholder: 'Selecciona un paciente', allowClear: true });
	$('select.select_capitulo').select2({ width: '350px', placeholder: 'Selecciona un motivo', allowClear: true });
	$('select.select_antecedente').select2({ width: '350px', placeholder: 'Selecciona un antecedente', allowClear: true});
	$('select.select_persona_hora').select2({ width: '350px', placeholder: 'Selecciona una persona', allowClear: true});

	$(".select_persona_hora").on("change", function(e) { 
		var h = $(this).attr('id').substring(20); 
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
})