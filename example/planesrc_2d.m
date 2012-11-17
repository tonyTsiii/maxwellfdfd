clear all; close all; clear classes; clc;

%% Set flags.
isnew = true;
inspect_only = false;

%% Solve the system.
y_flux_loc = 10;
if isnew
	[E, H, obj_array, src_array] = maxwell_run(1e-9, 100, ...
		{'vacuum', 'none', 1.0}, [-50, 50; -60, 60; 0, 1], 1, BC.p, [0 10 0], ...
		{'vacuum', 'none', 1.0}, Plane(Axis.y, y_flux_loc, 1), ...
		PlaneSrc(Axis.y, 0, Axis.z), inspect_only);  % PlaneSrc(plane_normal_axis, intercept, polarization_axis)

	if ~inspect_only
		save(mfilename, 'E', 'H', 'obj_array');
	end
else
	load(mfilename);
end

%% Visualize the solution.
figure
vis2d(E{Axis.z}, Axis.z, 0, obj_array, src_array)

%% Calculate the power emanating from the source.
power = powerflux_patch(E, H, Axis.y, y_flux_loc);
fprintf('power = %e\n', power);
