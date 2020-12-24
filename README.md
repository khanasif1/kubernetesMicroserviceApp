# Kubernetes Microservice Application
Microservice architecture based kubernetes application
<!-- wp:heading -->
<h2>Application Overview</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>For this blog the application architecture I have used involves stateful and stateless applications. </p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":4784,"width":753,"height":505,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://khanasif1.files.wordpress.com/2020/11/apparch-1.png?w=820" alt="" class="wp-image-4784" width="753" height="505"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The solution comprised of below components:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Polyglot database design, SQL container instance on Linux are used<ul><li><span class="has-inline-color has-luminous-vivid-orange-color"><strong>Staff DB (SQL Server container) :</strong> </span>This store all staff records</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Product DB <strong>(SQL Server container)</strong>:</span></strong> This will hold all product records</li></ul></li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Staff API (.NET Core): </span></strong>This API layer helps in accessing staff records</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">Product API <strong>(.NET Core)</strong>:</span></strong> This API helps in accessing product records</li><li><span class="has-inline-color has-luminous-vivid-orange-color"><b>Sales API (</b></span><strong><span class="has-inline-color has-luminous-vivid-orange-color">NodeJS):</span></strong> This API consumes Staff and Product API it then massages the data to build enriched Sales entity by mapping products with staff.</li><li><strong><span class="has-inline-color has-luminous-vivid-orange-color">UI Frontend (ASPNET Core):</span></strong> UI has Home screen from where you can navigate to Staff , Product or Sales records.</li></ul>
<!-- /wp:list -->