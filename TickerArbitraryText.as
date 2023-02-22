/*
 * Copyright (c) 2023 MisfitMaid <misfit@misfitmaid.com>
 * Use of this source code is governed by the MIT license, which
 * can be found in the LICENSE file.
 */

[Setting category="Display" name="Enable" description="Toggle plugin activity. May require reload."]
bool tatEnabled = true;

[Setting category="Text"]
string text1;

[Setting category="Text"]
string text2;

[Setting category="Text"]
string text3;

[Setting category="Text"]
string text4;

[Setting category="Text"]
string text5;

[Setting category="Text"]
string text6;

[Setting category="Text"]
string text7;

[Setting category="Text"]
string text8;

void Main() {
    init();
}
void OnSettingsChanged() { init(); }
void OnEnabled() { init(); }

/**
 * Register the plugin with Ticker upon startup
 */
void init() {
    if (!tatEnabled) return;
    Ticker::registerTickerItemProviderAddon(ArbitraryText());
}

/**
 * Primary entry point for the ticker plugin. Implement the TickerItemProvider interface
 */
class ArbitraryText : Ticker::TickerItemProvider {

    /**
     * Identifier for your provider. recommended format: "plugin-identifier/something-else"
     */
    string getID() {
        return "ticker-arbitrary-text/TAT";
    }
    
    /**
     * return an array of your TickerItem implementation (see below)
     */
    Ticker::TickerItem@[] getItems() {
        Ticker::TickerItem@[] arr;
        for (uint i = 1; i <= 8; i++) {
            string x = getLine(i);
            if (x.Length == 0) continue;

            arr.InsertLast(ArbitraryTextItem(x, i));
        }
        return arr;
    }
    
    /**
     * If you're doing expensive data gathering, do it here and update class values as needed.
     * This is called periodically by Ticker based on a user config settings.
     * 
     * safe to yield if needed
     */
    void OnUpdate() {}

    /**
     * vaguely cursed internal function
     */
    string getLine(uint line) {
        if (line == 1) return text1;
        if (line == 2) return text2;
        if (line == 3) return text3;
        if (line == 4) return text4;
        if (line == 5) return text5;
        if (line == 6) return text6;
        if (line == 7) return text7;
        if (line == 8) return text8;
        return "";
    }
}

/**
 * Your implementation of the TickerItem interface
 */
class ArbitraryTextItem : Ticker::TickerItem {

    string content;
    uint weight;
    
    /**
     * do whatever u want for the constructor
     */
    ArbitraryTextItem() {}
    ArbitraryTextItem(const string &in content, uint weight) {
        this.content = content;
        this.weight = weight;
    }

    /**
     * recommended you dont do any heavy lifting here
     */
    string getItemText() {
        return content;
    }

    /**
     * unix timestamp of your item's "date".
     */
    uint64 getSortTime() const {
        return Time::Stamp + (8-weight);
    }

    /**
     * called if user is hovering on your tickerItem. good for tooltips or whatever
     * 
     * example of use (with TaskbarItem, but its the same thing):
     * https://github.com/MisfitMaid/tm-ticker/blob/f47b0483bd5a7a2338f24749579117fb4a24ce39/Provider.Internal.as#L13-L18
     */
    void OnItemHovered() {}

    /**
     * called if user clicks your item. good for OpenBrowserURL() or something
     * 
     * example of use:
     * https://github.com/MisfitMaid/tm-ticker/blob/f47b0483bd5a7a2338f24749579117fb4a24ce39/Provider.TMioCampaign.as#L145-L147
     */
    void OnItemClick() {}
}
