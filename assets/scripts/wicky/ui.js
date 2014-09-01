
wicky.ui = {};

(function (ui, jQuery) {

	ui.editorUpdateInterval = 2000;

	ui.editable = function(editor) {
		var binder = ui.binder(editor.data('binder'));
		var blocking = false;
		if (!editor.is('input, textarea')) {
			return;
		}

		function editorOnAction (ev) {
			var markdown_text = editor.val();
			if (blocking || !markdown_text) {
				return;
			}
			blocking = true;
			binder.update({
				method: 'get',
				data: {
					md: markdown_text
				}
			}).done(function () {
				setTimeout(function () {
					blocking = false;
				}, ui.editorUpdateInterval);
			});
		}

		['change', 'keypress', 'paste', 'click', 'focus'].forEach(function (eventName) {
			editor.on(eventName, editorOnAction);
		});
	};

	ui.binder = (function (binders) {
		return function (id) {
			var bindingContainer, bindUpdateAPI;
			if (!binders.hasOwnProperty(id)) {
				bindingContainer = jQuery('[data-bind-id=' + id + ']');
				bindUpdateAPI = bindingContainer.data('bind-update-api');
				binders[id] = {
					update: function (config) {
						return jQuery.ajax(bindUpdateAPI, config).done(function (html) {
							bindingContainer.html(html);
						});
					}
				};
			}
			return binders[id];
		};
	}({}));

}(wicky.ui, jQuery));

