function handler () {
  EVENT_DATA=$1
    echo "$EVENT_DATA" 1>&2;
      RESPONSE="Echoing request: '$EVENT_DATA'"

        # Testing commands
        echo $RESPONSE
        aws --version
        kubectl version --client --output=yaml
        echo "done"

}