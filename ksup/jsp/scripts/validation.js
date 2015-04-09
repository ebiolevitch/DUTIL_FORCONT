(function($){

    /**
     * jQuery validation
     */

        // Custom date format validation
    $.validator.addMethod("ksupDate",
        function ksupDate(value, element){
            if(!value) return true;
            var regExp =/([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/g,
                values = regExp.exec(value);
            if(values == null || regExp.test(value)) return false;
            var day = $.parseInteger(values[1]),
                month = $.parseInteger(values[2]),
                year = $.parseInteger(values[3]);
            if(day > 31 || month > 12) return false;
            return !(month == 2 && day > 29);

        }, LOCALE_BO.validationMessages.ksupDate);

    // Custom phone format validation
    $.validator.addMethod("ksupPhone",
        function ksupPhone(value, element){
            if(!value) return true;
            var regExp =/^((\+)*[0-9]{1,3}|0)[0-9]{9}$/;
            return regExp.test(value);
        }, LOCALE_BO.validationMessages.ksupPhone);

    // Custom phone format validation
    $.validator.addMethod("constraint",
        function constraint(value, element){
            var hasInvalidClass = $(element).hasClass('js-constraint-violation__field');
            if (hasInvalidClass) {
                $(element).removeClass('js-constraint-violation__field');
            }
            return !hasInvalidClass;
        }, LOCALE_BO.validationMessages.constraint);

    $.validator.addClassRules("type_phone", {
        "required" : function(element){
            return $(element).prop('required');
        },
        ksupPhone : true
    });

    $.validator.addClassRules("type_email", {
        "required" : function(element){
            return $(element).prop('required');
        },
        "email" : true
    });

    $.validator.addClassRules("type_date", {
        required: function(element){
            return $(element).prop('required');
        },
        ksupDate : true,
        maxlength: 10
    });

    $.validator.addClassRules("type_url", {
        required: function(element){
            return $(element).prop('required');
        },
        url : true
    });

    $.validator.addClassRules("numeric_input", {
        required: function(element){
            return $(element).prop('required');
        },
        digits: true
    });

    $.validator.addClassRules("js-constraint-violation__field", {
        constraint : true
    });

    var $formToValidate = $('form');

    $formToValidate.find('input + .js-constraint-violation__message').each(function(){
        var $currentElement = $(this);
        var input = $currentElement.prev();
        input.addClass('js-constraint-violation__field');
        input.attr('data-msg-constraint', $currentElement.text());
    });

    var validateOptions = {
        ignore: '.ignore, :hidden',
        focusCleanup: true,
        errorElement : 'div'
    };

    $formToValidate.each(function(index ,component){
        var $component = $(component);
        $component.validate(validateOptions);
    });

    var serverErrorFields = $formToValidate.find('[data-msg-constraint]');
    if (serverErrorFields.length > 0) {
        serverErrorFields.valid(validateOptions);
    }

    /**
     * Input helper
     */
    /**
     * Tooltips : montre le nombre de caractères qui peuvent être saisis
     */

    var $maxedInputs = $('form:not([data-no-tooltip]) input[type="text"][maxlength], form:not([data-no-tooltip]) textarea[maxlength]');
    if($maxedInputs.length > 0){
        $maxedInputs.removeAttr('title');
        $maxedInputs.each(function(index, component){
            var $component = $(component);
            $component.tooltip({
                placement: 'right',
                title: $component.val().length + " / " + $component.attr('maxlength') + " caractères autorisés",
                trigger: 'focus'
            });
            $component.bind('change keyup blur input focus', updateToolTip);
            if($component.is(':focus')) $component.tooltip('show');
        });
    };

    $('textarea[maxlength]').bind('keyup blur', function () {
        var $this = $(this),
            len = $this[0].value.replace(/(\r\n|\n|\r)/g, '--').length,
            maxlength = $this.attr('maxlength');
        if (maxlength && len > maxlength) {
            var delta = len - maxlength;
            $this.val($this.val().slice(0, maxlength - delta));
        }
    });

    function updateToolTip(){
        var $this = $(this),
            popover = $(this).data('tooltip'),
            tip = popover.tip(),
            len = $this[0].value.replace(/(\r\n|\n|\r)/g, '--').length;

        popover.options.content = len + " / " + $(this).attr('maxlength') + " caractères autorisés";
        popover.options.title = popover.options.content;

        var visible = popover && tip && tip.is(':visible');

        if (visible) {
            tip.find('.tooltip-inner').html(popover.options.content);
        } else {
            popover.show();
        }
    }

    /**
     * Password strength meter
     */
    var options = {
        ui : {
            bootstrap2: true,
            showVerdicts: false,
            showErrors: true,
            verdicts: LOCALE_BO.validationMessages.pwdVerdicts,
            errorMessages: LOCALE_BO.validationMessages.pwdErrorMessages
        }
    };
    if(window.pwsOptions){
        $.extend(true, options, window.pwsOptions);
    }
    $('.pwdStrength :password').pwstrength(options);
    $formToValidate.triggerHandler("validate.ready");
})(jQuery.noConflict());