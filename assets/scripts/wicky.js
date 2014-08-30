
var wicky = {
	ui: {}
};

(function (ui, jQuery) {
	ui.editable = function (spec) {
		var blocking = false;

		spec.form.on('submit', formOnSubmit);
		['change', 'keypress', 'paste', 'click'].forEach(function (eventName) {
			spec.editor.on(eventName, editorOnAction);
		});

		function editorOnAction (ev) {
			if (blocking) {
				return;
			}
			blocking = true;
			jQuery.ajax(spec.previewAPI, {
				data: {
					md: spec.editor.val()
				}
			}).done(function (html) {
				spec.view.html(html);
				setTimeout(function () {
					blocking = false;
				}, 4000);
			});
		}

		function formOnSubmit (ev) {
			ev.preventDefault();
			jQuery.ajax(spec.saveAPI, {
				type: 'POST',
				data: spec.form.serialize()
			});
			return false;
		}
	};
}(wicky.ui, jQuery));

