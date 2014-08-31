
var wicky = {
	ui: {}
};

(function (ui, jQuery) {
	ui.editable = function (spec) {
		var blocking = false;

		spec.form.on('submit', formOnSubmit);
		['change', 'keypress', 'paste', 'click', 'focus'].forEach(function (eventName) {
			spec.editor.on(eventName, editorOnAction);
		});

		function editorOnAction (ev) {
			var markdown_text = spec.editor.val();
			if (blocking || !markdown_text) {
				return;
			}
			blocking = true;
			jQuery.ajax(spec.previewAPI, {
				data: {
					md: markdown_text
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

