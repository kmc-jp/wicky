
wicky.projects = {};

(function (ui, projects, jQuery) {

	var views = {};

	projects.main = function () {
		silenceForm();
		views.modifySummaryForm = jQuery('form[name="modify-summary"]');
		views.summaryEditor = views.modifySummaryForm.find('textarea[name="summary"]');
		views.addParticipationForm = jQuery('form[name="add-participation"]');
		views.addScheduleForm = jQuery('form[name="add-schedule"]');
		uiProjectSummaryEditor();
		uiModifySummaryForm();
		uiAddParticipationForm();
		uiAddScheduleForm();
	};

	function silenceForm () {
		jQuery('form').silence();
	}

	function uiProjectSummaryEditor () {
		ui.editable(views.summaryEditor);
	}

	function uiModifySummaryForm () {
		views.modifySummaryForm.on('submit', function (ev) {
			ui.binder(views.modifySummaryForm.data('binder')).update({
				method: 'get',
				data: {
					md: views.summaryEditor.val()
				}
			});
		});
	}

	function uiAddParticipationForm () {
		views.addParticipationForm.on('submit', function (ev) {
			ui.binder(views.addParticipationForm.data('binder')).update();
		});
	}

	function uiAddScheduleForm () {
		views.addScheduleForm.on('submit', function (ev) {
			ui.binder(views.addScheduleForm.data('binder')).update();
		});
	}

}(wicky.ui, wicky.projects, jQuery));

