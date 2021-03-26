package domain;

public class Guquan {

    private String corpname;
    private String type;
    private String username;
    private String bili;
    private String money;

    public String getCorpname() {
        return corpname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setCorpname(String corpname) {
        this.corpname = corpname;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBili() {
        return bili;
    }

    public void setBili(String bili) {
        this.bili = bili;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }
}
