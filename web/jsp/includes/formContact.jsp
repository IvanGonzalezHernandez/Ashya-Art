<section class="py-5" style="background-color: #EFE5DB; color: #3E3028;">
    <div class="container d-flex justify-content-center">
        <div class="p-4 rounded shadow animate__animated animate__fadeInUp" style="max-width: 700px; width: 100%; background-color: #EFE5DB;">

            <h2 class="text-center mb-4" style="color: #3E3028;">Get in Touch with Ashya</h2>
            <p class="lead text-center mb-5" style="color: #3E3028;">
                Have a question, want to book a workshop, or just say hello? I'd love to hear from you.
            </p>

            <% 
                String exito = request.getParameter("exito");
                String error = request.getParameter("error");

                if (exito != null) {
            %>
                <div style="background-color: #d4edda; color: #155724; padding: 10px 15px; border-radius: 5px; margin-bottom: 15px; border: 1px solid #c3e6cb;">
                    <%= exito %>
                </div>
            <% 
                } else if (error != null) {
            %>
                <div style="background-color: #f8d7da; color: #721c24; padding: 10px 15px; border-radius: 5px; margin-bottom: 15px; border: 1px solid #f5c6cb;">
                    <%= error %>
                </div>
            <% 
                } 
            %>

            <form action="<%= request.getContextPath() %>/ContactServlet" method="post" enctype="application/x-www-form-urlencoded">

                <div class="mb-3 animate__animated animate__fadeInLeft">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" maxlength="50" required style="background-color: #F9F3EC;">
                </div>

                <div class="mb-3 animate__animated animate__fadeInDown">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" maxlength="50" required style="background-color: #F9F3EC;">
                </div>

                <div class="mb-3 animate__animated animate__fadeInRight">
                    <label for="message" class="form-label">Message</label>
                    <textarea class="form-control" id="message" name="message" rows="3" maxlength="500" required style="background-color: #F9F3EC;"></textarea>
                </div>

                <div class="animate__animated animate__fadeInUp text-start">
                    <button type="submit" class="btn btn-custom px-4 py-2">Send Message</button>
                </div>

            </form>

        </div>
    </div>
</section>
