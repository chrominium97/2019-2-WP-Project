package edu.skku.wp.model;

public class JsonResponse {
    private Boolean success;
    private String message;

    public JsonResponse(Boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public Boolean getSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }
}
