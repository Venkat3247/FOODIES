
document.addEventListener("DOMContentLoaded", function () {
    const toggleButton = document.getElementById("darkModeToggle");

    if (!toggleButton) {
        console.error("Foodies: darkModeToggle button not found.");
        return;
    }

    function setDarkMode(enabled) {
        document.body.classList.toggle("dark-mode", enabled);

        toggleButton.textContent = enabled
            ? "☀️ Light Mode"
            : "🌙 Dark Mode";

        toggleButton.setAttribute("aria-pressed", String(enabled));
    }

    // Restore the saved theme.
    let savedTheme = "light";

    try {
        savedTheme = localStorage.getItem("foodies-dark-mode") || "light";
    } catch (error) {
        console.warn("Unable to read saved theme.");
    }

    setDarkMode(savedTheme === "dark");

    // Toggle the theme when clicked.
    toggleButton.addEventListener("click", function () {
        const enabled = !document.body.classList.contains("dark-mode");

        setDarkMode(enabled);

        try {
            localStorage.setItem(
                "foodies-dark-mode",
                enabled ? "dark" : "light"
            );
        } catch (error) {
            console.warn("Unable to save theme.");
        }
    });
});
