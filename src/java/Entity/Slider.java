package Entity;

public class Slider {
    private int id;
    private String title;
    private String imageUrl;
    private String backlink;
    private boolean isActive;

    public Slider() {}

    public Slider(int id, String title, String imageUrl, String backlink, boolean isActive) {
        this.id = id;
        this.title = title;
        this.imageUrl = imageUrl;
        this.backlink = backlink;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getBacklink() { return backlink; }
    public void setBacklink(String backlink) { this.backlink = backlink; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}
