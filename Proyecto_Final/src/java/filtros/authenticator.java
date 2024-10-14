package filtros;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class authenticator implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicia el filtro, si es necesario
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // Verificar si el usuario tiene una sesión válida
        HttpSession session = httpRequest.getSession(false);
        // URL de la página de login
        String loginURI = httpRequest.getContextPath() + "/home.jsp";
        String loginServlet = httpRequest.getContextPath() + "/login";
        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginAction = httpRequest.getRequestURI().equals(loginServlet);
        boolean loggedIn = (session != null && session.getAttribute("usuario") != null);

        // Permitir también recursos estáticos
        boolean isResourceRequest = httpRequest.getRequestURI().contains("/resources/");

        if (loggedIn || isLoginRequest || isLoginAction || isResourceRequest) {
            // Si el usuario está autenticado o está intentando acceder a la página de login, continuar
            chain.doFilter(request, response);
        } else {
            // Si el usuario no está autenticado, redirigir a la página de login
            httpResponse.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
        // Código de limpieza si es necesario
    }
}
