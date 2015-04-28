$('#modal-container').on('shown.bs.modal', function (e) {
	$('select.select_paciente').select2({ width: '350px', placeholder: 'Selecciona un paciente', allowClear: true });
	$('select.select_motivo').select2({ width: '350px', placeholder: 'Selecciona un motivo', allowClear: true });
	$('select.select_antecedente').select2({ width: '350px', placeholder: 'Selecciona un motivo', allowClear: true });
})