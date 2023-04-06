{%- extends 'reveal/index.html.j2' -%}

{% block header %}
{{ super() }}
<link rel="stylesheet" href="./styles.css">
{% endblock %}

{% block footer_js %}
{{ super() }}
<script>
    var slides = document.querySelectorAll(".slides > section");
    slides.forEach((slideNode) => {
        const watermarkDiv = document.createElement("div");
        const watermarkP = document.createElement("p");
        watermarkP.textContent = "Ethan Swan, @eswan18";
        watermarkDiv.appendChild(watermarkP);
        watermarkDiv.classList.add("ethan-watermark");
        slideNode.appendChild(watermarkDiv);
    });
</script>
{% endblock %}
