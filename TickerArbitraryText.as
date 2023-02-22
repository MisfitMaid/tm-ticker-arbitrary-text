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
void OnSettingsChanged() { startnew(init); }
void OnEnabled() { init(); }

void init() {
    if (!tatEnabled) return;

    Ticker::registerTickerItemProviderAddon(ArbitraryText());
}

class ArbitraryText : Ticker::TickerItemProvider {
    ArbitraryText() {}

    string getID() {
        return "ticker-arbitrary-text/TAT";
    }
    
    Ticker::TickerItem@[] getItems() {
        Ticker::TickerItem@[] arr;
        for (uint i = 1; i <= 8; i++) {
            string x = getLine(i);
            if (x.Length == 0) continue;

            arr.InsertLast(ArbitraryTextItem(x, i));
        }
        return arr;
    }
    
    void OnUpdate() {}

    /**
     * vaguely cursed
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

class ArbitraryTextItem : Ticker::TickerItem {

    string content;
    uint weight;
    
    ArbitraryTextItem() {}
    ArbitraryTextItem(const string &in content, uint weight) {
        this.content = content;
        this.weight = weight;
    }

    string getItemText() {
        return content;
    }
    uint64 getSortTime() const {
        return Time::Stamp + (8-weight);
    }

    void OnItemHovered() {}
    void OnItemClick() {}
}
