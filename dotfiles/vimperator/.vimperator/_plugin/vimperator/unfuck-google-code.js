/*
 * Copyright ©2009 Kris Maglione <maglione.k at Gmail>
 *
 * Available under the terms of the MIT license.
 *
 * Version: 0.4
 */
function HttpFilter(name, store) {
    const TOPIC = "http-on-examine-response";
    const observerService = services.get("observer");
    const mimeService = Cc["@mozilla.org/mime;1"].getService(Ci.nsIMIMEService);

    this.extensionTypes = {
        "vimp":"text/plain",
    };

    this.patterns = [
        RegExp("http://[^\.]+\\.googlecode\\.com/issues/attachment?(?:.*&name|name)=([^&]+)"),
        RegExp("http://[^\.]+\\.googlecode\\.com/files/([^?]+)"),
    ];

    this.observe = function observe(subject, topic, data) {  
        if (topic != TOPIC)
            return;
        let channel = subject.QueryInterface(Ci.nsIHttpChannel);
        for (let [,pattern] in Iterator(this.patterns)) {
            if (m = pattern.exec(channel.name)) {
                m = /\.(.*)$/.exec(m[1]) || [0, ".txt"];
                let type = this.extensionTypes[m[1]];
                if (!type)
                    try {
                        type = mimeService.getTypeFromExtension(m[1])
                    } catch (e) {
                        type = "text/plain";
                    }

                if (/^text\//.test(type) && type != 'text/html')
                    type = "text/plain; charset=UTF-8";
                channel.setResponseHeader("Content-Disposition", "inline", false);
                channel.contentType = type;
            };
        }
    };

    this.unregister = function unregister() {
        try {
            observerService.removeObserver(this, TOPIC);
        }
        catch (e) {}
    };
    this.register = function register() {
        observerService.addObserver(this, TOPIC, false);
    };

    this.register();
};

if('http-filter' in storage)
    storage['http-filter'].unregister();

__proto__ = storage.newObject("http-filter", HttpFilter, false, null, null, true);

// vim:se sts=4 sw=4 et:
