function [LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN]=errors(sol_explicit,sol_implicit,sol_crank,pde_sol)

    % LTE --> Local truncation error
    % GTE --> Global truncation error
    % RTE --> Relative truncation error
    LTE_EE = max(max(abs(pde_sol - sol_explicit)));
    GTE_EE = sqrt(sum(sum((pde_sol - sol_explicit).^2)) / (numel(pde_sol)));
    RTE_EE = norm(pde_sol - sol_explicit, 'fro') / norm(pde_sol, 'fro');

    LTE_IE = max(max(abs(pde_sol - sol_implicit)));
    GTE_IE = sqrt(sum(sum((pde_sol - sol_implicit).^2)) / (numel(pde_sol)));
    RTE_IE = norm(pde_sol - sol_implicit, 'fro') / norm(pde_sol, 'fro');

    LTE_CN = max(max(abs(pde_sol - sol_crank)));
    GTE_CN = sqrt(sum(sum((pde_sol - sol_crank).^2)) / (numel(pde_sol)));
    RTE_CN = norm(pde_sol - sol_crank, 'fro') / norm(pde_sol, 'fro');

end