
wicky.projects = {};

(function (ui, projects, jQuery) {
	projects.main = function () {
		uiEditable();
	};

	function uiEditable() {
		jQuery('section.ui-editable').each(function () {
			var section = jQuery(this);
			wicky.ui.editable({
				previewAPI: section.data('preview-api'),
				saveAPI: section.data('save-api'),
				view: section.find('.ui-editable-view'),
				form: section.find('.ui-editable-form'),
				editor: section.find('.ui-editable-editor')
			});
		});
	}
}(wicky.ui, wicky.projects, jQuery));

