
wicky.projects = {};

(function (ui, projects, jQuery) {

	projects.main = function () {
		uiEditable();
	};

	function uiEditable() {
		jQuery('section.ui-editable').each(function () {
			var section = jQuery(this);
			ui.editable({
				previewAPI: section.data('preview-api'),
				saveAPI: section.data('save-api'),
				editor: section.find('.ui-editable-editor'),
				view: section.find('.ui-editable-view'),
				form: section.find('.ui-editable-form')
			});
		});
	}

	function uiBind() {
		var binders = [];
		jQuery('section.ui-bind').each(function () {
			var section = jQuery(this);
			var binder = ui.bind({
				id: section.data('bind-id'),
				bindUpdateAPI: section.data('bind-update-api'),
				bindingSection: section
			});
			binders.push(binder);
		});
		jQuery('form[name="add-schedule"]').silence().on('submit', function (ev) {
			binders.forEach(function (binder) {
				binder.update();
			});
		});
	}

}(wicky.ui, wicky.projects, jQuery));

