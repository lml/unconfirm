(function($) {
    "use strict";
    var root = this;
    var Unconfirm = root.Unconfirm = function unconfirmRoot(options) {
        var self = this;
        if (typeof options === 'string') {
            options = {};
            options.actionSelector = options;
        }
        this.options = $.extend({}, Unconfirm.DefaultOptions, options);
        this.$selector = $(this.options.actionSelector);
        this.$selector.click(function(e) {
            var $clicked = $(e.currentTarget);
            if ($clicked.hasClass(self.options.unconfirmedClass)) {
                // The user has already pressed the continue button.
                $clicked.removeClass(self.options.unconfirmedClass);
                return true;
            }
            var setting = $clicked.data('unconfirmSetting');
            // The user has already opted to skip this dialog.
            // Leave them alone.
            if (!self.needsConfirm(setting)) return true;
            // Pester time.
            $clicked.addClass(self.options.unconfirmingClass);
            var dialogData = self.extractOptions($clicked);
            self.render(dialogData);
            self.showDialog(dialogData, $clicked);
            return false;
        });
    };

    Unconfirm.DefaultData = {
        unconfirmSetting: "",
        unconfirmMessage: "Are you sure?",
        unconfirmMessageTitle: "",
        unconfirmDontShowText: "Please don't show this again.",
        unconfirmContinueText: "Continue",
        unconfirmCancelText: "Cancel"
    };

    Unconfirm.DefaultOptions = {
        actionSelector: '.unconfirm',
        dialogSelector: "#unconfirm_dialog",
        dialogBodySelector: ".uc-dialog-body",
        dialogDontShowCheckSelector: ".uc-dont-show-check",
        dialogDontShowTextSelector: ".uc-dont-show-label",
        unconfirmingClass: 'unconfirming',
        unconfirmedClass: 'unconfirmed'
    };

    Unconfirm.prototype.changeSetting = function(dialogData, $check) {
        window.unconfirmUserSettings[dialogData.unconfirmSetting] = $check.is(':checked');
        $check.closest('form').submit();
    };

    Unconfirm.prototype.closing = function() {
        var $dialog = $(this.options.dialogSelector);
        var $check = $dialog.find(this.options.dialogDontShowCheckSelector);
        $check.off();
    };

    Unconfirm.prototype.render = function render(dialogData) {
        var self = this;
        var $dialog = $(this.options.dialogSelector);
        $dialog.find(this.options.dialogBodySelector).html(dialogData.unconfirmMessage);
        $dialog.find(this.options.dialogDontShowTextSelector).html(dialogData.unconfirmDontShowText);
        var $check = $dialog.find(this.options.dialogDontShowCheckSelector);
        $check.attr("name", "settings[" + dialogData.unconfirmSetting + "]");
        $check.click(function() {
            self.changeSetting(dialogData, $check);
        });
    };

    Unconfirm.prototype.extractOptions = function extractOptions($clicked) {
        var data = $clicked.data();
        var options = {};
        $.each(Unconfirm.DefaultData, function(key, value) {
            options[key] = data[key] || value;
        });
        return options;
    };

    Unconfirm.prototype.onUnconfirmed = function unconfirmed($clicked) {
        $clicked.removeClass(this.options.unconfirmingClass);
        $clicked.addClass(this.options.unconfirmedClass);
        $clicked.trigger('click');
    };

    Unconfirm.prototype.needsConfirm = function needsConfirm(setting) {
        return window.unconfirmUserSettings[setting] !== true;
    };


    Unconfirm.prototype.showDialog = function showDialog(dialogData, $clicked) {
        var unconfirm = this;
        $(this.options.dialogSelector).dialog({
            autoOpen: false,
            modal: true,
            height: 300,
            width: 400,
            title: dialogData.unconfirmMessageTitle,
            position: 'center',
            closeOnEscape: true,
            buttons: [{
                text: dialogData.unconfirmCancelText,
                click: function() {
                    unconfirm.closing();
                    $(this).dialog('close');
                }
            }, {
                text: dialogData.unconfirmContinueText,
                click: function() {
                    unconfirm.closing();
                    $(this).dialog('close');
                    unconfirm.onUnconfirmed($clicked);
                }
            }]
        });
        $(this.options.dialogSelector).dialog('open');
    };

    $.fn.unconfirm = function unconfirmJQuery(options) {
        options = options || {};
        options.actionSelector = this;
        this.unconfirm = new Unconfirm(options);
    };
}).call(this, jQuery);
