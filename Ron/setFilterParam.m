function setFilterParam(h)
    d = uiprogressdlg(h.d.f,'Title','Please Wait',...
        'Message','Loading',...
        'Indeterminate','on',...
        'Cancelable','on');
    
    if isfield(h.d,'Particles')
        delete(h.d.Particles);
    end
    if isfield(h.d,'traceGraph')
        delete(h.d.traceGraph);
    end
    
    stack = h.d.Video.stack;
    frame = h.d.Video.videoPanel.frame;
    h.d.Centers = particleDetector(im2double(stack(:,:,frame)), h.d.IntenSlider.Value,...
                                                               h.d.EccSlider.Value,....
                                                               h.d.EdgeSlider.Value,...
                                                               h.d.NearSlider.Value, d);

    if d.CancelRequested
        return;
    end
   
    if size(h.d.Centers,1) > 0
        hold(h.d.Video.videoPanel.axes.axes,'on');
        h.d.Particles = plot(h.d.Video.videoPanel.axes.axes, h.d.Centers(:,1), h.d.Centers(:,2), 'oc');
        h.d.Particles.PickableParts = 'none';
        hold(h.d.Video.videoPanel.axes.axes,'off');
    end
    
    close(d);
end