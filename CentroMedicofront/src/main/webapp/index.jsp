<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
<div class="container">
    <section class="vh-100 d-flex align-items-center">
        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-md-9 col-lg-6 col-xl-5">
                    <img src="assets/ccticLogo.png" class="img-fluid" alt="Imagen de muestra">
                </div>
                <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                    <form id="user-form" action="${pageContext.request.contextPath}/users/login" method="post">
                        <!-- Email input -->
                        <div class="form-outline mb-4">
                            <input type="text" id="correo" name="correo" class="form-control form-control-lg" placeholder="Ingresa un correo electrónico válido" required />
                            <label class="form-label" for="correo">Correo electrónico</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline mb-3">
                            <input type="password" id="contrasenia" name="contrasenia" class="form-control form-control-lg" placeholder="Ingresa la contraseña" required />
                            <label class="form-label" for="contrasenia">Contraseña</label>
                        </div>

                        <!-- Submit button -->
                        <div class="text-center">
                            <button id="login" type="submit" class="btn btn-primary btn-lg">Iniciar sesión</button>
                        </div>

                        <!-- Error message -->
                        <c:if test="${not empty errorMessage}">
                            <p style="color: red;" class="mt-3">${errorMessage}</p>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- SweetAlert2 script -->  <!--CREO QUE ESTA ALERTA NO FUNCIONA -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("user-form");
        const btn = document.getElementById("login");

        form.addEventListener("submit", function (event){
            btn.innerHTML = `<div class="d-flex justify-content-center">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>`;
            btn.classList.add("disabled");
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                btn.classList.remove("disabled");
                btn.innerHTML = 'Iniciar sesión';
            }
            form.classList.add("was-validated");
        }, false);

        const urlParams = new URLSearchParams(window.location.search);
        const successParam = urlParams.get('success');
        const errorParam = urlParams.get('error');
        const mensaje = urlParams.get('message');
        if (successParam === 'true') {
            Swal.fire({
                icon: 'success',
                title: '¡Inicio de sesión exitoso!',
                text: mensaje || '¡Bienvenido!',
                showConfirmButton: false,
                timer: 1500
            });
        } else if (errorParam === 'true') {
            Swal.fire({
                icon: 'error',
                title: '¡Inicio de sesión fallido!',
                text: mensaje || 'Correo electrónico o contraseña incorrectos',
            });
        }
    });
</script>
</body>
</html>
