FROM alpine

USER root
ADD script.sh .
RUN chmod +x script.sh

CMD ["./script.sh"]
# ENTRYPOINT [ "./script.sh" ]