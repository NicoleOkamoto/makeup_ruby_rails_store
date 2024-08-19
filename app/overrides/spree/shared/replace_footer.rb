Deface::Override.new(
  virtual_path: 'spree/shared/_footer',
  name: 'replace_footer',
  replace: 'footer',
  text: <<-HTML
      <!-- Footer -->
      <footer class="text-white pt-5" style="background-color: #0f0e11">
        <!-- Container -->
        <div class="container">
          <!-- About Us and Contact Information -->
          <div class="row mb-5">
            <!-- About Us -->
            <div class="col-md-6 mb-4 mb-md-0">
              <h5 class="text-uppercase mb-3">About Us</h5>
              <p>
                ELEVE MAKEUP is a Canadian-owned beauty brand based in Winnipeg, Manitoba, offering high-quality makeup
                products for over 10 years. Our mission is to empower individuals through innovative cosmetics that
                celebrate diversity and elevate beauty standards. Explore our premium products at our retail stores
                and pop-up events.
              </p>
            </div>

            <!-- Contact Information -->
            <div class="col-md-6 mb-5 mb-md-0">
              <h5 class="text-uppercase mb-3">Contact Us</h5>
              <p>
                123 Beauty Lane<br>
                Winnipeg, MB R3A 1B2<br>
                Phone: (123) 456-7890<br>
                Email: <a href="mailto:info@elevemakeup.com" class="text-white">info@elevemakeup.com</a>
              </p>
            </div>
          </div>

          <!-- Social Media Icons -->
          <div class="row mb-2 pb-1">
            <div class="col text-center">

              <a href="https://www.facebook.com/" class="text-white me-3 p-2">
                <img src="<%= asset_path('social/facebook.png') %>" alt="Facebook" style="width: 24px; height: 24px;">
              </a>
              <a href="https://www.instagram.com/" class="text-white me-3 p-2">
                <img src="<%= asset_path('social/instagram.png') %>" alt="Instagram" style="width: 24px; height: 24px;">
              </a>
            </div>
          </div>
           <div class="row mb-2 pb-1">
            <div class="col text-center">
            <a class="text-white" href="https://github.com/NicoleOkamoto">©2024 NicoleOkamoto</a>
            </div>
          </div>
        </div>
      </footer>
  HTML
)
