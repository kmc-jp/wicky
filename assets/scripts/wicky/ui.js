
wicky.ui = {};

(function (ui, jQuery) {

	ui.editable = function (spec) {
		var blocking = false;

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

		['change', 'keypress', 'paste', 'click', 'focus'].forEach(function (eventName) {
			spec.editor.on(eventName, editorOnAction);
		});
	};

	ui.bind = function (spec) {
		var binder = {}, bindingSection = spec.bindingSection, bindUpdateAPI = spec.bindUpdateAPI;
		binder.update = function () {
			bindingSection.load(bindUpdateAPI);
		};
		return binder;
	};

}(wicky.ui, jQuery));

