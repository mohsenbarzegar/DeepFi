function spec=create_my_array(filename);
    csi_trace= read_bf_file(filename);
    csi_entry=csi_trace{1}
    spec=get_scaled_csi(csi_entry);
    
end