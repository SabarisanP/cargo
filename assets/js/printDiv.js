!(function (e) {
    var t;
    (e.fn.printThis = function (n) {
      t = e.extend({}, e.fn.printThis.defaults, n);
      var i = this instanceof jQuery ? this : e(this),
        a = "printThis-" + new Date().getTime();
      if (
        window.location.hostname !== document.domain &&
        navigator.userAgent.match(/msie/i)
      ) {
        var r =
            'javascript:document.write("<head><script>document.domain=\\"' +
            document.domain +
            '\\";</script></head><body></body>")',
          o = document.createElement("iframe");
        (o.name = "printIframe"),
          (o.id = a),
          (o.className = "MSIE"),
          document.body.appendChild(o),
          (o.src = r);
      } else e("<iframe id='" + a + "' name='printIframe' />").appendTo("body");
      var d = e("#" + a);
      t.debug ||
        d.css({
          position: "absolute",
          width: "0px",
          height: "0px",
          left: "-600px",
          top: "-600px",
        }),
        setTimeout(function () {
          var n = d.contents(),
            a = n.find("head"),
            r = n.find("body");
          if (
            (a.append(
              '<base href="' +
                document.location.protocol +
                "//" +
                document.location.host +
                '">'
            ),
            t.importCSS &&
              e("link[rel=stylesheet]").each(function () {
                var t = e(this).attr("href");
                if (t) {
                  var n = e(this).attr("media") || "all";
                  a.append(
                    "<link type='text/css' rel='stylesheet' href='" +
                      t +
                      "' media='" +
                      n +
                      "'>"
                  );
                }
              }),
            t.importStyle &&
              e("style").each(function () {
                e(this).clone().appendTo(a);
              }),
            t.pageTitle && a.append("<title>" + t.pageTitle + "</title>"),
            t.loadCSS &&
              (e.isArray(t.loadCSS)
                ? jQuery.each(t.loadCSS, function (e, t) {
                    a.append(
                      "<link type='text/css' rel='stylesheet' href='" +
                        this +
                        "'>"
                    );
                  })
                : a.append(
                    "<link type='text/css' rel='stylesheet' href='" +
                      t.loadCSS +
                      "'>"
                  )),
            t.header && r.append(t.header),
            t.printContainer
              ? r.append(i.outer())
              : i.each(function () {
                  r.append(e(this).html());
                }),
            t.formValues)
          ) {
            var o = i.find("input");
            o.length &&
              o.each(function () {
                var t = e(this),
                  i = e(this).attr("name"),
                  a = t.is(":checkbox") || t.is(":radio"),
                  r = n.find('input[name="' + i + '"]'),
                  o = t.val();
                a
                  ? t.is(":checked") &&
                    (t.is(":checkbox")
                      ? r.attr("checked", "checked")
                      : t.is(":radio") &&
                        n
                          .find('input[name="' + i + '"][value=' + o + "]")
                          .attr("checked", "checked"))
                  : r.val(o);
              });
            var s = i.find("select");
            s.length &&
              s.each(function () {
                var t = e(this),
                  i = e(this).attr("name"),
                  a = t.val();
                n.find('select[name="' + i + '"]').val(a);
              });
            var c = i.find("textarea");
            c.length &&
              c.each(function () {
                var t = e(this),
                  i = e(this).attr("name"),
                  a = t.val();
                n.find('textarea[name="' + i + '"]').val(a);
              });
          }
          t.removeInline &&
            (e.isFunction(e.removeAttr)
              ? n.find("body *").removeAttr("style")
              : n.find("body *").attr("style", "")),
            setTimeout(function () {
              d.hasClass("MSIE")
                ? (window.frames.printIframe.focus(),
                  a.append("<script>  window.print(); </script>"))
                : (d[0].contentWindow.focus(), d[0].contentWindow.print()),
                t.debug ||
                  setTimeout(function () {
                    d.remove();
                  }, 1e3);
            }, t.printDelay);
        }, 333);
    }),
      (e.fn.printThis.defaults = {
        debug: !1,
        importCSS: !0,
        importStyle: !1,
        printContainer: !0,
        loadCSS: "",
        pageTitle: "",
        removeInline: !1,
        printDelay: 333,
        header: null,
        formValues: !0,
      }),
      (jQuery.fn.outer = function () {
        return e(e("<div></div>").html(this.clone())).html();
      });
  })(jQuery);
  